import '../../domain/entities/notification_entity.dart';
import '../../domain/repositories/notification_repository.dart';
import '../datasources/notification_remote_data_source.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationRemoteDataSource remoteDataSource;

  NotificationRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<NotificationEntity>> getNotifications() async {
    final models = await remoteDataSource.getNotifications();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<int> getUnreadCount() async {
    return await remoteDataSource.getUnreadCount();
  }

  @override
  Future<void> markAllAsRead() async {
    return await remoteDataSource.markAllAsRead();
  }

  @override
  Future<void> markAsRead(int id) async {
    return await remoteDataSource.markAsRead(id);
  }
}
