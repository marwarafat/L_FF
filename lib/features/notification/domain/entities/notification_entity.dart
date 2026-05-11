class NotificationEntity {
  final int id;
  final String title;
  final String subtitle;
  final String time;
  final bool isRead;
  final String? type;

  NotificationEntity({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.isRead,
    this.type,
  });
}
