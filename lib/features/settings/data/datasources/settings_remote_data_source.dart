import 'package:dio/dio.dart';
import '../../../../core/networking/api_consumer.dart';
import '../../../../core/network/end_points.dart';
import '../../../../core/utils/token_storage.dart';

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
  final ApiConsumer _apiConsumer;
  final TokenStorage _tokenStorage;

  SettingsRemoteDataSourceImpl({
    required ApiConsumer apiConsumer,
    required TokenStorage tokenStorage,
  }) : _apiConsumer = apiConsumer,
       _tokenStorage = tokenStorage;

  @override
  Future<void> updateProfile({
    required String fullName,
    required String phone,
    String? location,
    String? profilePicturePath,
  }) async {
    final formData = FormData.fromMap({
      'FullName': fullName,
      'Phone': phone,
      if (location != null) 'Location': location,
      if (profilePicturePath != null)
        'ProfilePicture': await MultipartFile.fromFile(profilePicturePath),
    });

    await _apiConsumer.put(
      EndPoints.currentUser,
      data: formData,
      headers: {'requiresAuth': true},
    );
  }

  @override
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    await _apiConsumer.post(
      EndPoints.changePassword,
      data: {
        'currentPassword': currentPassword,
        'newPassword': newPassword,
      },
      headers: {'requiresAuth': true},
    );
  }

  @override
  Future<void> deleteAccount({required String password}) async {
    await _apiConsumer.delete(
      EndPoints.deleteAccount,
      data: {'password': password},
      headers: {'requiresAuth': true},
    );
  }

  @override
  Future<void> logout({required String refreshToken}) async {
    try {
      await _apiConsumer.post(
        EndPoints.logout,
        data: {'refreshToken': refreshToken},
        headers: {'requiresAuth': true},
      );
    } catch (_) {
      // Silently fail — still clear local data
    } finally {
      await _tokenStorage.clear();
      // Also clear SharedPreferences token for compatibility
      // We don't have direct access to CacheHelper here but we can import it
    }
  }
}
