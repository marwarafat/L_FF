import '../../../../core/network/api_requests.dart';
import '../../../../core/network/end_points.dart';
import '../../../../core/storage/token_storage.dart';
import '../models/notification_model.dart';

abstract class NotificationRemoteDataSource {
  Future<List<NotificationModel>> getNotifications();
  Future<int> getUnreadCount();
  Future<void> markAllAsRead();
  Future<void> markAsRead(int id);
}

class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  final ApiRequests _apiRequests;

  NotificationRemoteDataSourceImpl({ApiRequests? apiRequests})
    : _apiRequests = apiRequests ?? ApiRequests();

  Future<String?> _getToken() async {
    return CacheHelper.getData(key: "token");
  }

  @override
  Future<List<NotificationModel>> getNotifications() async {
    final token = await _getToken();
    if (token == null) throw Exception("Token not found");

    final response = await _apiRequests.getData(
      path: EndPoints.notifications,
      token: token,
    );

    final List data = response.data['data']['notifications'];
    return data.map((e) => NotificationModel.fromJson(e)).toList();
  }

  @override
  Future<int> getUnreadCount() async {
    final token = await _getToken();
    if (token == null) throw Exception("Token not found");

    final response = await _apiRequests.getData(
      path: EndPoints.unreadCount,
      token: token,
    );

    return response.data['data']['unreadCount'] ?? 0;
  }

  @override
  Future<void> markAllAsRead() async {
    final token = await _getToken();
    if (token == null) throw Exception("Token not found");

    await _apiRequests.postData(
      path: EndPoints.markAllRead,
      data: {},
      token: token,
    );
  }

  @override
  Future<void> markAsRead(int id) async {
    final token = await _getToken();
    if (token == null) throw Exception("Token not found");

    await _apiRequests.postData(
      path: "${EndPoints.markRead}/$id/read",
      data: {},
      token: token,
    );
  }
}
