import 'package:flutter/material.dart';
import '../../../domain/entities/notification_entity.dart';
import 'notification_item.dart';

class NotificationsList extends StatelessWidget {
  final List<NotificationEntity> notifications;
  const NotificationsList({super.key, required this.notifications});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: notifications.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) =>
          NotificationItem(notification: notifications[index]),
    );
  }
}
