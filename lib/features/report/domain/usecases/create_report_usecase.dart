import '../repositories/report_repository.dart';

class CreateReportUseCase {
  final ReportRepository repository;

  CreateReportUseCase(this.repository);

  Future<void> call({
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
    return await repository.createReport(
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
