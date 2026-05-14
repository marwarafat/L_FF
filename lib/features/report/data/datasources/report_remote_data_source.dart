import 'package:dio/dio.dart';
import '../../../../core/networking/api_consumer.dart';
import '../../../../core/network/end_points.dart';
import '../models/category_mapping_model.dart';

abstract class ReportRemoteDataSource {
  Future<List<CategoryMappingModel>> getCategoryMapping();
  Future<void> createReport({
    required String title,
    required String description,
    required String type,
    required int subCategoryId,
    String? locationName,
    double? latitude,
    double? longitude,
    DateTime? dateReported,
    List<String>? imagePaths,
  });
}

class ReportRemoteDataSourceImpl implements ReportRemoteDataSource {
  final ApiConsumer _apiConsumer;

  ReportRemoteDataSourceImpl({required ApiConsumer apiConsumer})
    : _apiConsumer = apiConsumer;

  @override
  Future<List<CategoryMappingModel>> getCategoryMapping() async {
    try {
      final response = await _apiConsumer.get(
        EndPoints.categoriesMapping,
      );
      final List<dynamic> data = response['data'] ?? [];
      return data.map((e) => CategoryMappingModel.fromJson(e)).toList();
    } catch (e) {
      throw Exception('Failed to load categories: $e');
    }
  }

  @override
  Future<void> createReport({
    required String title,
    required String description,
    required String type,
    required int subCategoryId,
    String? locationName,
    double? latitude,
    double? longitude,
    DateTime? dateReported,
    List<String>? imagePaths,
  }) async {
    final Map<String, dynamic> fields = {
      'Title': title,
      'Description': description,
      'Type': type,
      'SubCategoryId': subCategoryId,
      if (locationName != null && locationName.isNotEmpty)
        'LocationName': locationName,
      if (latitude != null) 'Latitude': latitude,
      if (longitude != null) 'Longitude': longitude,
      if (dateReported != null) 'DateReported': dateReported.toIso8601String(),
    };

    if (imagePaths != null && imagePaths.isNotEmpty) {
      fields['Images'] = [
        for (final path in imagePaths) await MultipartFile.fromFile(path),
      ];
    }

    final formData = FormData.fromMap(fields);

    await _apiConsumer.post(
      EndPoints.createReport,
      data: formData,
      headers: {'requiresAuth': true},
    );
  }
}
