import '../../../../core/network/api_requests.dart';
import '../../../../core/network/end_points.dart';
import '../../../../core/storage/token_storage.dart';
import '../models/chat_session_model.dart';
import '../models/chat_message_model.dart';

abstract class ChatRemoteDataSource {
  Future<List<ChatSessionModel>> getChatSessions();
  Future<List<ChatMessageModel>> getChatMessages(int sessionId);
  Future<ChatMessageModel> sendMessage(int sessionId, String text);
  Future<void> markMessageAsRead(int messageId);
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final ApiRequests _apiRequests;

  ChatRemoteDataSourceImpl({ApiRequests? apiRequests})
    : _apiRequests = apiRequests ?? ApiRequests();

  Future<String?> _getToken() async {
    return CacheHelper.getData(key: "token");
  }

  @override
  Future<List<ChatSessionModel>> getChatSessions() async {
    final token = await _getToken();
    if (token == null) throw Exception("No token found");

    final response = await _apiRequests.getData(
      path: EndPoints.chat + "/sessions",
      token: token,
    );

    if (response.statusCode == 200) {
      final data = response.data['data'] as List;
      return data.map((json) => ChatSessionModel.fromJson(json)).toList();
    } else {
      throw Exception(response.data['message'] ?? 'Failed to load sessions');
    }
  }

  @override
  Future<List<ChatMessageModel>> getChatMessages(int sessionId) async {
    final token = await _getToken();
    if (token == null) throw Exception("No token found");

    final response = await _apiRequests.getData(
      path: EndPoints.chat + "/sessions/$sessionId/messages",
      token: token,
    );

    if (response.statusCode == 200) {
      final data = response.data['data'] as List;
      return data.map((json) => ChatMessageModel.fromJson(json)).toList();
    } else {
      throw Exception(response.data['message'] ?? 'Failed to load messages');
    }
  }

  @override
  Future<ChatMessageModel> sendMessage(int sessionId, String text) async {
    final token = await _getToken();
    if (token == null) throw Exception("No token found");

    final response = await _apiRequests.postData(
      path: EndPoints.chat + "/sessions/$sessionId/messages",
      data: {"text": text},
      token: token,
    );

    if (response.statusCode == 200) {
      return ChatMessageModel.fromJson(response.data['data']);
    } else {
      throw Exception(response.data['message'] ?? 'Failed to send message');
    }
  }

  @override
  Future<void> markMessageAsRead(int messageId) async {
    final token = await _getToken();
    if (token == null) return;

    await _apiRequests.putData(
      path: EndPoints.chat + "/messages/$messageId/read",
      data: null,
      token: token,
    );
  }
}
