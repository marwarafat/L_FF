import '../../../../core/networking/api_consumer.dart';
import '../../../../core/network/end_points.dart';
import '../models/notification_model.dart';

abstract class NotificationRemoteDataSource {
  Future<List<NotificationModel>> getNotifications();
  Future<int> getUnreadCount();
  Future<void> markAllAsRead();
  Future<void> markAsRead(int id);
}

class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  final ApiConsumer _apiConsumer;

  NotificationRemoteDataSourceImpl({required ApiConsumer apiConsumer})
    : _apiConsumer = apiConsumer;

  @override
  Future<List<NotificationModel>> getNotifications() async {
    final response = await _apiConsumer.get(
      EndPoints.notifications,
      headers: {'requiresAuth': true},
    );

    final List data = response['data']['notifications'];
    return data.map((e) => NotificationModel.fromJson(e)).toList();
  }

  @override
  Future<int> getUnreadCount() async {
    final response = await _apiConsumer.get(
      EndPoints.unreadCount,
      headers: {'requiresAuth': true},
    );

    return response['data']['unreadCount'] ?? 0;
  }

  @override
  Future<void> markAllAsRead() async {
    await _apiConsumer.post(
      EndPoints.markAllRead,
      data: {},
      headers: {'requiresAuth': true},
    );
  }

  @override
  Future<void> markAsRead(int id) async {
    await _apiConsumer.post(
      "${EndPoints.markRead}/$id/read",
      data: {},
      headers: {'requiresAuth': true},
    );
  }
}
