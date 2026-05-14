import '../../../../core/networking/api_consumer.dart';
import '../../../../core/network/end_points.dart';
import '../models/chat_session_model.dart';
import '../models/chat_message_model.dart';

abstract class ChatRemoteDataSource {
  Future<List<ChatSessionModel>> getChatSessions();
  Future<List<ChatMessageModel>> getChatMessages(int sessionId);
  Future<ChatMessageModel> sendMessage(int sessionId, String text);
  Future<void> markMessageAsRead(int messageId);
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final ApiConsumer _apiConsumer;

  ChatRemoteDataSourceImpl({required ApiConsumer apiConsumer})
    : _apiConsumer = apiConsumer;

  @override
  Future<List<ChatSessionModel>> getChatSessions() async {
    final response = await _apiConsumer.get(
      EndPoints.chat + "/sessions",
      headers: {'requiresAuth': true},
    );

    final data = response['data'] as List;
    return data.map((json) => ChatSessionModel.fromJson(json)).toList();
  }

  @override
  Future<List<ChatMessageModel>> getChatMessages(int sessionId) async {
    final response = await _apiConsumer.get(
      EndPoints.chat + "/sessions/$sessionId/messages",
      headers: {'requiresAuth': true},
    );

    final data = response['data'] as List;
    return data.map((json) => ChatMessageModel.fromJson(json)).toList();
  }

  @override
  Future<ChatMessageModel> sendMessage(int sessionId, String text) async {
    final response = await _apiConsumer.post(
      EndPoints.chat + "/sessions/$sessionId/messages",
      data: {"text": text},
      headers: {'requiresAuth': true},
    );

    return ChatMessageModel.fromJson(response['data']);
  }

  @override
  Future<void> markMessageAsRead(int messageId) async {
    await _apiConsumer.put(
      EndPoints.chat + "/messages/$messageId/read",
      data: null,
      headers: {'requiresAuth': true},
    );
  }
}
