import '../repositories/settings_repository.dart';

class UpdateProfileUseCase {
  final SettingsRepository repository;

  UpdateProfileUseCase(this.repository);

  Future<void> call({
    required String fullName,
    required String phone,
    String? location,
    String? profilePicturePath,
  }) async {
    return await repository.updateProfile(
      fullName: fullName,
      phone: phone,
      location: location,
      profilePicturePath: profilePicturePath,
    );
  }
}
