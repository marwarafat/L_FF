import '../repositories/settings_repository.dart';

class DeleteAccountUseCase {
  final SettingsRepository repository;

  DeleteAccountUseCase(this.repository);

  Future<void> call({required String password}) async {
    return await repository.deleteAccount(password: password);
  }
}
