import '../entities/report_summary_entity.dart';
import '../repositories/profile_repository.dart';

class GetUserReportsUseCase {
  final ProfileRepository repository;

  GetUserReportsUseCase(this.repository);

  Future<List<ReportSummaryEntity>> call({
    int page = 1,
    int pageSize = 20,
  }) async {
    return await repository.getUserReports(page: page, pageSize: pageSize);
  }
}
