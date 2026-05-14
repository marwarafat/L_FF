import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_notifications_usecase.dart';
import '../../domain/usecases/get_unread_count_usecase.dart';
import '../../domain/usecases/mark_all_as_read_usecase.dart';
import '../../domain/usecases/mark_as_read_usecase.dart';
import 'notification_event.dart';
import 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final GetNotificationsUseCase getNotificationsUseCase;
  final GetUnreadCountUseCase getUnreadCountUseCase;
  final MarkAllAsReadUseCase markAllAsReadUseCase;
  final MarkAsReadUseCase markAsReadUseCase;

  NotificationBloc({
    required this.getNotificationsUseCase,
    required this.getUnreadCountUseCase,
    required this.markAllAsReadUseCase,
    required this.markAsReadUseCase,
  }) : super(
         NotificationState(
           notifications: [],
           filteredNotifications: [],
           selectedTab: 0,
           unreadCount: 0,
         ),
       ) {
    /// 🔵 Load Notifications
    on<LoadNotificationsEvent>((event, emit) async {
      emit(state.copyWith(loading: true));
      try {
        final list = await getNotificationsUseCase();
        emit(
          state.copyWith(
            notifications: list,
            filteredNotifications: list,
            selectedTab: 0,
            loading: false,
          ),
        );
      } catch (e) {
        print("LOAD ERROR: $e");
        emit(state.copyWith(loading: false, errorMessage: e.toString()));
      }
    });

    /// 🔴 Unread Count
    on<LoadUnreadCountEvent>((event, emit) async {
      try {
        final count = await getUnreadCountUseCase();
        emit(state.copyWith(unreadCount: count));
      } catch (e) {
        print("UNREAD ERROR: $e");
      }
    });

    /// 🔄 Change Tabs
    on<ChangeTabEvent>((event, emit) {
      if (event.index == 0) {
        emit(
          state.copyWith(
            filteredNotifications: state.notifications,
            selectedTab: 0,
          ),
        );
      } else if (event.index == 1) {
        final unread = state.notifications.where((n) => !n.isRead).toList();
        emit(state.copyWith(filteredNotifications: unread, selectedTab: 1));
      } else if (event.index == 2) {
        final matches = state.notifications
            .where((n) => n.type == "match" || n.type == "status_update")
            .toList();
        emit(state.copyWith(filteredNotifications: matches, selectedTab: 2));
      }
    });

    /// ✅ Mark All Read
    on<MarkAllAsReadEvent>((event, emit) async {
      try {
        await markAllAsReadUseCase();
        // Reload to get updated status
        add(LoadNotificationsEvent());
        emit(state.copyWith(unreadCount: 0));
      } catch (e) {
        print("MARK ALL ERROR: $e");
      }
    });

    /// 🟢 Mark One Read
    on<MarkNotificationAsReadEvent>((event, emit) async {
      try {
        await markAsReadUseCase(event.id);
        // Reload to get updated status
        add(LoadNotificationsEvent());
        add(LoadUnreadCountEvent());
      } catch (e) {
        print("MARK ONE ERROR: $e");
      }
    });
  }
}
