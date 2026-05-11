abstract class SettingsRepository {
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
