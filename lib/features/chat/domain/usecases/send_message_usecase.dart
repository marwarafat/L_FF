import '../entities/chat_message_entity.dart';
import '../repositories/chat_repository.dart';

class SendMessageUseCase {
  final ChatRepository repository;

  SendMessageUseCase(this.repository);

  Future<ChatMessageEntity> call(int sessionId, String text) async {
    return await repository.sendMessage(sessionId, text);
  }
}
