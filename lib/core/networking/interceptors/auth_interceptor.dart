import 'package:dio/dio.dart';
import '../../../core/networking/api_constants.dart';
import '../../../core/utils/token_storage.dart';

class AuthInterceptor extends Interceptor {
  final Dio dio;
  final TokenStorage storage;

  AuthInterceptor(this.dio, this.storage);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await storage.getAccessToken();
    final bool requiresAuth = options.headers['requiresAuth'] == true;
    
    if (token != null && requiresAuth) {
      options.headers.remove('requiresAuth');
      options.headers['Authorization'] = 'Bearer $token';
    }

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      final refresh = await storage.getRefreshToken();

      if (refresh != null) {
        try {
          final response = await dio.post(
            ApiConstants.refreshToken,
            data: {"refreshToken": refresh},
          );

          final newAccess = response.data["data"]["accessToken"];
          final newRefresh = response.data["data"]["refreshToken"];

          await storage.saveTokens(newAccess, newRefresh);

          final requestOptions = err.requestOptions;
          requestOptions.headers['Authorization'] = 'Bearer $newAccess';

          final cloned = await dio.fetch(requestOptions);
          return handler.resolve(cloned);
        } catch (_) {
          await storage.clear();
        }
      }
    }

    super.onError(err, handler);
  }
}
