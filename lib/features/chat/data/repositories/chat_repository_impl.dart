import '../../domain/entities/chat_session_entity.dart';
import '../../domain/entities/chat_message_entity.dart';
import '../../domain/repositories/chat_repository.dart';
import '../datasources/chat_remote_data_source.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource remoteDataSource;

  ChatRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<ChatSessionEntity>> getChatSessions() async {
    final models = await remoteDataSource.getChatSessions();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<List<ChatMessageEntity>> getChatMessages(int sessionId) async {
    final models = await remoteDataSource.getChatMessages(sessionId);
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<ChatMessageEntity> sendMessage(int sessionId, String text) async {
    final model = await remoteDataSource.sendMessage(sessionId, text);
    return model.toEntity();
  }

  @override
  Future<void> markMessageAsRead(int messageId) async {
    return await remoteDataSource.markMessageAsRead(messageId);
  }
}
