import '../../domain/entities/category_mapping_entity.dart';
import '../../domain/repositories/report_repository.dart';
import '../datasources/report_remote_data_source.dart';

class ReportRepositoryImpl implements ReportRepository {
  final ReportRemoteDataSource remoteDataSource;

  ReportRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<CategoryMappingEntity>> getCategoryMapping() async {
    return await remoteDataSource.getCategoryMapping();
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
    return await remoteDataSource.createReport(
      title: title,
      description: description,
      type: type,
      subCategoryId: subCategoryId,
      locationName: locationName,
      latitude: latitude,
      longitude: longitude,
      dateReported: dateReported,
      imagePaths: imagePaths,
    );
  }
}
