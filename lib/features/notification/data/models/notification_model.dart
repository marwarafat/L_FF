import '../../domain/entities/notification_entity.dart';

class NotificationModel extends NotificationEntity {
  NotificationModel({
    required super.id,
    required super.title,
    required super.subtitle,
    required super.time,
    required super.isRead,
    super.type,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? "Notification",
      subtitle: json['message'] ?? "",
      time: json['createdAt']?.toString().split('T')[0] ?? "",
      isRead: json['isRead'] ?? false,
      type: json['notificationType'],
    );
  }

  NotificationEntity toEntity() {
    return NotificationEntity(
      id: id,
      title: title,
      subtitle: subtitle,
      time: time,
      isRead: isRead,
      type: type,
    );
  }
}
