import '../../domain/repositories/settings_repository.dart';
import '../datasources/settings_remote_data_source.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsRemoteDataSource remoteDataSource;

  SettingsRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> updateProfile({
    required String fullName,
    required String phone,
    String? location,
    String? profilePicturePath,
  }) async {
    return await remoteDataSource.updateProfile(
      fullName: fullName,
      phone: phone,
      location: location,
      profilePicturePath: profilePicturePath,
    );
  }

  @override
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    return await remoteDataSource.changePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
    );
  }

  @override
  Future<void> deleteAccount({required String password}) async {
    return await remoteDataSource.deleteAccount(password: password);
  }

  @override
  Future<void> logout({required String refreshToken}) async {
    return await remoteDataSource.logout(refreshToken: refreshToken);
  }
}
