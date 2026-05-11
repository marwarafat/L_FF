import '../repositories/chat_repository.dart';

class MarkMessageAsReadUseCase {
  final ChatRepository repository;

  MarkMessageAsReadUseCase(this.repository);

  Future<void> call(int messageId) async {
    return await repository.markMessageAsRead(messageId);
  }
}
