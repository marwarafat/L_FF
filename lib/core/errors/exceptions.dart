import 'package:dio/dio.dart';

class ServerException implements Exception {
  final String message;
  final int? statusCode;

  ServerException(this.message, {this.statusCode});

  factory ServerException.fromDio(DioException e) {
    final data = e.response?.data;
    final statusCode = e.response?.statusCode;

    if (data is Map<String, dynamic>) {
      final message = data['message'];
      if (message != null && message.toString().isNotEmpty) {
        return ServerException(message.toString(), statusCode: statusCode);
      }

      final errors = data['errors'];
      if (errors is Map<String, dynamic> && errors.isNotEmpty) {
        final messages = errors.values
            .expand(
              (v) => v is List ? v.map((e) => e.toString()) : [v.toString()],
            )
            .join(', ');
        return ServerException(messages, statusCode: statusCode);
      }

      final title = data['title'];
      if (title != null && title.toString().isNotEmpty) {
        return ServerException(title.toString(), statusCode: statusCode);
      }
    }

    switch (statusCode) {
      case 400:
        return ServerException('Invalid request. Please check your data.', statusCode: statusCode);
      case 401:
        return ServerException('Unauthorized. Please login again.', statusCode: statusCode);
      case 403:
        return ServerException('Access denied.', statusCode: statusCode);
      case 404:
        return ServerException('Resource not found.', statusCode: statusCode);
      case 409:
        return ServerException('This email is already registered.', statusCode: statusCode);
      case 422:
        return ServerException('Validation error. Please check your inputs.', statusCode: statusCode);
      case 500:
        return ServerException('Server error. Please try again later.', statusCode: statusCode);
      default:
        return ServerException(e.message ?? 'Unexpected error occurred.', statusCode: statusCode);
    }
  }

  @override
  String toString() => message;
}
