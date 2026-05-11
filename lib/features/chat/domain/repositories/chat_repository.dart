import '../entities/chat_session_entity.dart';
import '../entities/chat_message_entity.dart';

abstract class ChatRepository {
  Future<List<ChatSessionEntity>> getChatSessions();
  Future<List<ChatMessageEntity>> getChatMessages(int sessionId);
  Future<ChatMessageEntity> sendMessage(int sessionId, String text);
  Future<void> markMessageAsRead(int messageId);
}
