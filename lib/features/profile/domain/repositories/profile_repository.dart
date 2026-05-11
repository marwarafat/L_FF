import '../entities/profile_entity.dart';
import '../entities/report_summary_entity.dart';

abstract class ProfileRepository {
  Future<ProfileEntity> getUserProfile();
  Future<List<ReportSummaryEntity>> getUserReports({
    int page = 1,
    int pageSize = 20,
  });
}
