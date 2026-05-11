import 'package:flutter/material.dart';
import '../../../domain/entities/notification_entity.dart';
import '../../../../../core/styles/app_colors.dart';

class NotificationItem extends StatelessWidget {
  final NotificationEntity notification;
  const NotificationItem({super.key, required this.notification});

  Widget _getIcon(String? type) {
    switch (type) {
      case 'new_message':
        return Image.asset(
          'assets/icons/comment_icon.png',
          color: AppColors.primary,
          width: 24,
          height: 24,
        );
      case 'match':
        return const Icon(
          Icons.favorite_border,
          color: AppColors.primary,
          size: 24,
        );
      default:
        return const Icon(
          Icons.notifications_active_outlined,
          color: AppColors.primary,
          size: 24,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: notification.isRead
            ? Colors.white.withOpacity(0.7)
            : Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: _getIcon(notification.type),
        ),
        title: Text(
          notification.title,
          style: TextStyle(
            fontFamily: 'AbhayaLibre',
            fontSize: 16,
            fontWeight: notification.isRead ? FontWeight.w500 : FontWeight.w800,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              notification.subtitle,
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
            const SizedBox(height: 6),
            Text(
              notification.time,
              style: TextStyle(fontSize: 12, color: Colors.grey[500]),
            ),
          ],
        ),
        trailing: !notification.isRead
            ? const CircleAvatar(radius: 5, backgroundColor: AppColors.primary)
            : null,
      ),
    );
  }
}
