import 'package:dio/dio.dart';
import '../utils/token_storage.dart';
import 'interceptors/auth_interceptor.dart';
import 'interceptors/logging_interceptor.dart';
import 'api_constants.dart';

class DioClient {
  static Dio create(TokenStorage storage) {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
      ),
    );

    dio.interceptors.addAll([
      AuthInterceptor(dio, storage),
      LoggingInterceptor(),
    ]);

    return dio;
  }
}
