import 'package:dio/dio.dart';
import '../../../../core/network/api_requests.dart';
import '../../../../core/network/end_points.dart';
import '../../../../core/storage/token_storage.dart';

abstract class SettingsRemoteDataSource {
  Future<void> updateProfile({
    required String fullName,
    required String phone,
    String? location,
    String? profilePicturePath,
  });
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  });
  Future<void> deleteAccount({required String password});
  Future<void> logout({required String refreshToken});
}

class SettingsRemoteDataSourceImpl implements SettingsRemoteDataSource {
  final ApiRequests _apiRequests;

  SettingsRemoteDataSourceImpl({ApiRequests? apiRequests})
      : _apiRequests = apiRequests ?? ApiRequests();

  Future<String?> _getToken() async {
    return CacheHelper.getData(key: "token");
  }

  @override
  Future<void> updateProfile({
    required String fullName,
    required String phone,
    String? location,
    String? profilePicturePath,
  }) async {
    final token = await _getToken();
    if (token == null) throw Exception("Not authenticated");

    final formData = FormData.fromMap({
      'FullName': fullName,
      'Phone': phone,
      if (location != null) 'Location': location,
      if (profilePicturePath != null)
        'ProfilePicture': await MultipartFile.fromFile(profilePicturePath),
    });

    final response = await _apiRequests.putMultipart(
      path: EndPoints.currentUser,
      formData: formData,
      token: token,
    );

    if (response.statusCode != 200) {
      throw Exception(response.data['message'] ?? 'Failed to update profile');
    }
  }

  @override
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    final token = await _getToken();
    if (token == null) throw Exception("Not authenticated");

    final response = await _apiRequests.postData(
      path: EndPoints.changePassword,
      data: {
        'currentPassword': currentPassword,
        'newPassword': newPassword,
      },
      token: token,
    );

    if (response.statusCode != 200) {
      throw Exception(response.data['message'] ?? 'Failed to change password');
    }
  }

  @override
  Future<void> deleteAccount({required String password}) async {
    final token = await _getToken();
    if (token == null) throw Exception("Not authenticated");

    final response = await _apiRequests.deleteData(
      path: EndPoints.deleteAccount,
      token: token,
      data: {'password': password},
    );

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception(response.data['message'] ?? 'Failed to delete account');
    }
  }

  @override
  Future<void> logout({required String refreshToken}) async {
    final token = await _getToken();
    if (token == null) return;

    try {
      await _apiRequests.postData(
        path: EndPoints.logout,
        data: {'refreshToken': refreshToken},
        token: token,
      );
    } catch (_) {
      // Silently fail — still clear local data
    } finally {
      await CacheHelper.removeData(key: "token");
      await CacheHelper.removeData(key: "refreshToken");
    }
  }
}
