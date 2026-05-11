import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../l10n/app_localizations.dart';
import '../bloc/notification_bloc.dart';
import '../bloc/notification_state.dart';
import '../bloc/notification_event.dart';
import '../../domain/usecases/get_notifications_usecase.dart';
import '../../domain/usecases/get_unread_count_usecase.dart';
import '../../domain/usecases/mark_all_as_read_usecase.dart';
import '../../domain/usecases/mark_as_read_usecase.dart';
import '../../data/datasources/notification_remote_data_source.dart';
import '../../data/repositories/notification_repository_impl.dart';
import 'widgets/notification_tabs.dart';
import 'widgets/notifications_list.dart';
import '../../../../core/styles/app_colors.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (context) {
        final dataSource = NotificationRemoteDataSourceImpl();
        final repository = NotificationRepositoryImpl(dataSource);

        return NotificationBloc(
            getNotificationsUseCase: GetNotificationsUseCase(repository),
            getUnreadCountUseCase: GetUnreadCountUseCase(repository),
            markAllAsReadUseCase: MarkAllAsReadUseCase(repository),
            markAsReadUseCase: MarkAsReadUseCase(repository),
          )
          ..add(LoadNotificationsEvent())
          ..add(LoadUnreadCountEvent());
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF9F9F9),
        appBar: AppBar(
          title: Text(
            l10n.notifications,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontFamily: 'AbhayaLibre',
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0.5,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
              size: 18,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            BlocBuilder<NotificationBloc, NotificationState>(
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.only(right: 16, top: 8),
                  child: Stack(
                    children: [
                      const Icon(
                        Icons.notifications_none_outlined,
                        color: Colors.black,
                        size: 28,
                      ),
                      if (state.unreadCount > 0)
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            constraints: const BoxConstraints(
                              minWidth: 16,
                              minHeight: 16,
                            ),
                            child: Text(
                              '${state.unreadCount}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
        body: BlocBuilder<NotificationBloc, NotificationState>(
          builder: (context, state) {
            return Column(
              children: [
                const SizedBox(height: 10),
                NotificationTabs(
                  selectedTab: state.selectedTab,
                  onTabChanged: (index) => context.read<NotificationBloc>().add(
                    ChangeTabEvent(index),
                  ),
                ),
                Expanded(
                  child: state.notifications.isEmpty && state.loading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primary,
                          ),
                        )
                      : NotificationsList(
                          notifications: state.filteredNotifications,
                        ),
                ),
                _buildMarkAsReadButton(context),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildMarkAsReadButton(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          onPressed: () {
            context.read<NotificationBloc>().add(MarkAllAsReadEvent());
            context.read<NotificationBloc>().add(LoadUnreadCountEvent());
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            elevation: 0,
          ),
          child: Text(
            l10n.markAllAsRead,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
