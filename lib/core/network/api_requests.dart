import 'package:dio/dio.dart';
import 'api_constants.dart';

class ApiRequests {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
    ),
  );

  Future<Response> getData({
    required String path,
    required String token,
  }) async {
    print("DEBUG: Sending GET to -> ${ApiConstants.baseUrl}$path");
    print("DEBUG: Token -> ${token.isNotEmpty ? "EXISTS" : "EMPTY"}");
    try {
      return await _dio.get(
        path,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json",
          },
        ),
      );
    } catch (e) {
      if (e is DioException) {
        print("DEBUG: Dio Error Type -> ${e.type}");
        print("DEBUG: Status Code -> ${e.response?.statusCode}");
        print("DEBUG: Response Data -> ${e.response?.data}");
        var data = e.response?.data;
        String message = e.message ?? "GET Error";
        if (data is Map) {
          message = data['message'] ?? message;
        } else if (data is String) {
          message = data;
        }
        throw Exception(message);
      }
      throw Exception("GET Error: $e");
    }
  }

  Future<Response> postData({
    required String path,
    required Map<String, dynamic> data,
    required String token,
  }) async {
    try {
      return await _dio.post(
        path,
        data: data,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/json",
          },
        ),
      );
    } catch (e) {
      if (e is DioException) {
        var data = e.response?.data;
        String message = e.message ?? "POST Error";
        if (data is Map) {
          message = data['message'] ?? message;
        } else if (data is String) {
          message = data;
        }
        throw Exception(message);
      }
      throw Exception("POST Error: $e");
    }
  }

  Future<Response> putData({
    required String path,
    required Map<String, dynamic>? data,
    required String token,
  }) async {
    try {
      return await _dio.put(
        path,
        data: data,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/json",
          },
        ),
      );
    } catch (e) {
      if (e is DioException) {
        var data = e.response?.data;
        String message = e.message ?? "PUT Error";
        if (data is Map) {
          message = data['message'] ?? message;
        } else if (data is String) {
          message = data;
        }
        throw Exception(message);
      }
      throw Exception("PUT Error: $e");
    }
  }

  Future<Response> putMultipart({
    required String path,
    required FormData formData,
    required String token,
  }) async {
    try {
      return await _dio.put(
        path,
        data: formData,
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );
    } catch (e) {
      if (e is DioException) {
        var data = e.response?.data;
        String message = e.message ?? "PUT Multipart Error";
        if (data is Map) {
          message = data['message'] ?? message;
        } else if (data is String) {
          message = data;
        }
        throw Exception(message);
      }
      throw Exception("PUT Multipart Error: $e");
    }
  }

  Future<Response> postMultipart({
    required String path,
    required FormData formData,
    required String token,
  }) async {
    try {
      return await _dio.post(
        path,
        data: formData,
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );
    } catch (e) {
      if (e is DioException) {
        var data = e.response?.data;
        String message = e.message ?? "POST Multipart Error";
        if (data is Map) {
          message = data['message'] ?? message;
        } else if (data is String) {
          message = data;
        }
        throw Exception(message);
      }
      throw Exception("POST Multipart Error: $e");
    }
  }

  Future<Response> deleteData({
    required String path,
    required String token,
    Map<String, dynamic>? data,
  }) async {
    try {
      return await _dio.delete(
        path,
        data: data,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/json",
          },
        ),
      );
    } catch (e) {
      if (e is DioException) {
        var data = e.response?.data;
        String message = e.message ?? "DELETE Error";
        if (data is Map) {
          message = data['message'] ?? message;
        } else if (data is String) {
          message = data;
        }
        throw Exception(message);
      }
      throw Exception("DELETE Error: $e");
    }
  }
}
