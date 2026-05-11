import '../entities/category_mapping_entity.dart';

abstract class ReportRepository {
  Future<List<CategoryMappingEntity>> getCategoryMapping();

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
