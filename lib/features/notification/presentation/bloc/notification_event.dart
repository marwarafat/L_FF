abstract class NotificationEvent {}

class LoadNotificationsEvent extends NotificationEvent {}

class LoadUnreadCountEvent extends NotificationEvent {}

class ChangeTabEvent extends NotificationEvent {
  final int index;
  ChangeTabEvent(this.index);
}

class MarkAllAsReadEvent extends NotificationEvent {}

class MarkNotificationAsReadEvent extends NotificationEvent {
  final int id;
  MarkNotificationAsReadEvent(this.id);
}
