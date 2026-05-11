import 'package:dio/dio.dart';
import '../../../../core/network/api_requests.dart';
import '../../../../core/network/end_points.dart';
import '../../../../core/storage/token_storage.dart';
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
  final ApiRequests _apiRequests;

  ProfileRemoteDataSourceImpl({ApiRequests? apiRequests})
    : _apiRequests = apiRequests ?? ApiRequests();

  @override
  Future<ProfileModel> getUserProfile() async {
    String token = CacheHelper.getData(key: "token") ?? "";

    try {
      Response response = await _apiRequests.getData(
        path: EndPoints.currentUser,
        token: token,
      );

      if (response.statusCode == 200) {
        return ProfileModel.fromJson(response.data['data']);
      } else {
        var errorMessage = 'Failed to load profile';
        if (response.data is Map) {
          errorMessage = response.data['message'] ?? errorMessage;
        } else {
          errorMessage = 'Server error: ${response.statusCode}';
        }
        throw Exception(errorMessage);
      }
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
    String token = CacheHelper.getData(key: "token") ?? "";

    try {
      Response response = await _apiRequests.getData(
        path: "${EndPoints.myReports}?page=$page&pageSize=$pageSize",
        token: token,
      );

      if (response.statusCode == 200) {
        var responseData = response.data;
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
      } else {
        var errorMessage = 'Failed to load reports';
        if (response.data is Map) {
          errorMessage = response.data['message'] ?? errorMessage;
        } else {
          errorMessage = 'Server error: ${response.statusCode}';
        }
        throw Exception(errorMessage);
      }
    } catch (e) {
      print("DEBUG: ProfileRemoteDataSource Error -> $e");
      throw Exception('Failed to load reports: $e');
    }
  }
}
