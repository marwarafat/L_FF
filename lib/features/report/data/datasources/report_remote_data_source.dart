import 'package:dio/dio.dart';
import '../../../../core/network/api_requests.dart';
import '../../../../core/network/end_points.dart';
import '../../../../core/storage/token_storage.dart';
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
  final ApiRequests _apiRequests;

  ReportRemoteDataSourceImpl({ApiRequests? apiRequests})
    : _apiRequests = apiRequests ?? ApiRequests();

  Future<String?> _getToken() async {
    return CacheHelper.getData(key: "token");
  }

  @override
  Future<List<CategoryMappingModel>> getCategoryMapping() async {
    try {
      final response = await _apiRequests.getData(
        path: EndPoints.categoriesMapping,
        token: '',
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'] ?? [];
        return data.map((e) => CategoryMappingModel.fromJson(e)).toList();
      }
      throw Exception(response.data['message'] ?? 'Failed to load categories');
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
    final token = await _getToken();
    if (token == null || token.isEmpty) throw Exception('Not authenticated');

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

    final response = await _apiRequests.postMultipart(
      path: EndPoints.createReport,
      formData: formData,
      token: token,
    );

    if (response.statusCode != 200) {
      throw Exception(response.data['message'] ?? 'Failed to submit report');
    }
  }
}
