import '../repositories/settings_repository.dart';

class LogoutUseCase {
  final SettingsRepository repository;

  LogoutUseCase(this.repository);

  Future<void> call({required String refreshToken}) async {
    return await repository.logout(refreshToken: refreshToken);
  }
}
