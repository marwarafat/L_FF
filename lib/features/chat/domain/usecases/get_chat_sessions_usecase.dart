import '../entities/chat_session_entity.dart';
import '../repositories/chat_repository.dart';

class GetChatSessionsUseCase {
  final ChatRepository repository;

  GetChatSessionsUseCase(this.repository);

  Future<List<ChatSessionEntity>> call() async {
    return await repository.getChatSessions();
  }
}
