import '../../../../core/networking/api_consumer.dart';
import '../../../../core/network/end_points.dart';
import '../models/profile_model.dart';
import '../models/report_summary_model.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileModel> getUserProfile();
  Future<List<ReportSummaryModel>> getUserReports({
    int page = 1,
    int pageSize = 20,
  });
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final ApiConsumer _apiConsumer;

  ProfileRemoteDataSourceImpl({required ApiConsumer apiConsumer})
    : _apiConsumer = apiConsumer;

  @override
  Future<ProfileModel> getUserProfile() async {
    try {
      final response = await _apiConsumer.get(
        EndPoints.currentUser,
        headers: {'requiresAuth': true},
      );

      return ProfileModel.fromJson(response['data']);
    } catch (e) {
      print("DEBUG: ProfileRemoteDataSource Error (Profile) -> $e");
      throw Exception('Failed to load profile: $e');
    }
  }

  @override
  Future<List<ReportSummaryModel>> getUserReports({
    int page = 1,
    int pageSize = 20,
  }) async {
    try {
      final response = await _apiConsumer.get(
        "${EndPoints.myReports}?page=$page&pageSize=$pageSize",
        headers: {'requiresAuth': true},
      );

      var responseData = response;
      List<dynamic> dataList = [];

      if (responseData is List) {
        dataList = responseData;
      } else if (responseData is Map) {
        var innerData = responseData['data'];
        if (innerData is List) {
          dataList = innerData;
        } else if (innerData is Map && innerData['data'] is List) {
          dataList = innerData['data'];
        }
      }
      return dataList
          .where((item) => item is Map<String, dynamic>)
          .map(
            (item) =>
                ReportSummaryModel.fromJson(item as Map<String, dynamic>),
          )
          .toList();
    } catch (e) {
      print("DEBUG: ProfileRemoteDataSource Error -> $e");
      throw Exception('Failed to load reports: $e');
    }
  }
}
