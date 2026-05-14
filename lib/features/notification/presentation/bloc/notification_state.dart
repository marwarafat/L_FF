import '../../domain/entities/notification_entity.dart';

class NotificationState {
  final List<NotificationEntity> notifications;
  final List<NotificationEntity> filteredNotifications;
  final int selectedTab;
  final int unreadCount;
  final bool loading;
  final String? errorMessage;

  NotificationState({
    required this.notifications,
    required this.filteredNotifications,
    required this.selectedTab,
    required this.unreadCount,
    this.loading = false,
    this.errorMessage,
  });

  NotificationState copyWith({
    List<NotificationEntity>? notifications,
    List<NotificationEntity>? filteredNotifications,
    int? selectedTab,
    int? unreadCount,
    bool? loading,
    String? errorMessage,
  }) {
    return NotificationState(
      notifications: notifications ?? this.notifications,
      filteredNotifications:
          filteredNotifications ?? this.filteredNotifications,
      selectedTab: selectedTab ?? this.selectedTab,
      unreadCount: unreadCount ?? this.unreadCount,
      loading: loading ?? this.loading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
