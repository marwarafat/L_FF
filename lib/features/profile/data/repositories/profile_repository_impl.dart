import '../../domain/entities/profile_entity.dart';
import '../../domain/entities/report_summary_entity.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_remote_data_source.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImpl(this.remoteDataSource);

  @override
  Future<ProfileEntity> getUserProfile() async {
    return await remoteDataSource.getUserProfile();
  }

  @override
  Future<List<ReportSummaryEntity>> getUserReports({
    int page = 1,
    int pageSize = 20,
  }) async {
    return await remoteDataSource.getUserReports(
      page: page,
      pageSize: pageSize,
    );
  }
}
