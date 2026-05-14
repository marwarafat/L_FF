import 'package:dio/dio.dart';
import '../../core/errors/exceptions.dart';
import 'api_consumer.dart';

class DioConsumer implements ApiConsumer {
  final Dio dio;

  DioConsumer(this.dio);

  @override
  Future get(String path,
      {Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    try {
      final res = await dio.get(path,
          queryParameters: queryParameters,
          options: Options(headers: {...?headers}));
      return res.data;
    } on DioException catch (e) {
      throw ServerException.fromDio(e);
    }
  }

  @override
  Future post(String path,
      {data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    try {
      final res = await dio.post(path,
          data: data,
          queryParameters: queryParameters,
          options: Options(headers: {...?headers}));
      return res.data;
    } on DioException catch (e) {
      throw ServerException.fromDio(e);
    }
  }

  @override
  Future delete(String path,
      {data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    try {
      final res = await dio.delete(path,
          data: data,
          queryParameters: queryParameters,
          options: Options(headers: {...?headers}));
      return res.data;
    } on DioException catch (e) {
      throw ServerException.fromDio(e);
    }
  }

  @override
  Future put(String path,
      {data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    try {
      final res = await dio.put(path,
          data: data,
          queryParameters: queryParameters,
          options: Options(headers: {...?headers}));
      return res.data;
    } on DioException catch (e) {
      throw ServerException.fromDio(e);
    }
  }
}
