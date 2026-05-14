import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../l10n/app_localizations.dart';
import '../bloc/chat_bloc.dart';
import '../bloc/chat_event.dart';
import '../bloc/chat_state.dart';
import 'full_chat_screen.dart';
import '../../domain/usecases/get_chat_sessions_usecase.dart';
import '../../domain/usecases/get_chat_messages_usecase.dart';
import '../../domain/usecases/send_message_usecase.dart';
import '../../domain/usecases/mark_message_as_read_usecase.dart';
import '../../domain/entities/chat_session_entity.dart';
import '../../../profile/domain/usecases/get_user_profile_usecase.dart';
import '../../data/datasources/chat_remote_data_source.dart';
import '../../data/repositories/chat_repository_impl.dart';
import '../../../profile/data/datasources/profile_remote_data_source.dart';
import '../../../profile/data/repositories/profile_repository_impl.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../auth/data/repo/auth_repo.dart';
import '../../../../core/styles/app_colors.dart';

import '../../../../core/di/service_locator.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  String formatTime(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return '';
    try {
      DateTime date = DateTime.parse(dateStr).toLocal();
      DateTime now = DateTime.now();
      if (date.year == now.year &&
          date.month == now.month &&
          date.day == now.day) {
        return DateFormat.Hm().format(date); // Just time if today
      } else {
        return DateFormat('MMM d').format(date); // Date if older
      }
    } catch (e) {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (_) => sl<ChatBloc>()..add(LoadChatSessionsEvent()),
      child: BlocBuilder<ChatBloc, ChatState>(
        buildWhen: (previous, current) =>
            current is ChatSessionsLoaded ||
            current is ChatSessionsLoading ||
            current is ChatError,
        builder: (context, state) {
          if (state is ChatSessionsLoading) {
            return const Scaffold(
              backgroundColor: Colors.white,
              body: Center(child: CircularProgressIndicator()),
            );
          }

          if (state is ChatError) {
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                  onPressed: () => Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRoutes.mainScreen,
                    (route) => false,
                  ),
                ),
              ),
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.error_outline, color: Colors.red, size: 60),
                      const SizedBox(height: 16),
                      Text(
                        "${l10n.failed}: ${state.message}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.red),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton.icon(
                        onPressed: () {
                          // Force logout
                          sl<AuthRepo>().logout();
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            AppRoutes.signInScreen,
                            (route) => false,
                          );
                        },
                        icon: const Icon(Icons.logout),
                        label: const Text("Logout & Login Again"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

          if (state is ChatSessionsLoaded) {
            if (state.sessions.isEmpty) {
              return Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                    onPressed: () => Navigator.pushNamedAndRemoveUntil(
                      context,
                      AppRoutes.mainScreen,
                      (route) => false,
                    ),
                  ),
                  title: Text(
                    l10n.messagesTitle,
                    style: const TextStyle(
                      fontFamily: 'AbhayaLibre',
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
                body: Center(child: Text(l10n.noActiveChats)),
              );
            }

            final sessions = List<ChatSessionEntity>.from(state.sessions);
            sessions.sort((a, b) {
              final aTime = a.lastMessageTime != null ? DateTime.parse(a.lastMessageTime!) : DateTime(0);
              final bTime = b.lastMessageTime != null ? DateTime.parse(b.lastMessageTime!) : DateTime(0);
              return bTime.compareTo(aTime);
            });

            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                  onPressed: () => Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRoutes.mainScreen,
                    (route) => false,
                  ),
                ),
                title: Text(
                  l10n.messagesTitle,
                  style: const TextStyle(
                    fontFamily: 'AbhayaLibre',
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),
              body: Container(
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListView.separated(
                  itemCount: sessions.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final session = sessions[index];
                    final user = session.otherUser;

                    return ListTile(
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundImage:
                            user?.profilePictureUrl != null &&
                                user!.profilePictureUrl!.startsWith('http')
                            ? NetworkImage(user.profilePictureUrl!)
                            : const AssetImage('assets/icons/profile_fill.png')
                                  as ImageProvider,
                      ),
                      title: Row(
                        children: [
                          Expanded(
                            child: Text(
                              user?.fullName ?? l10n.unknownUser,
                              style: const TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'AbhayaLibre',
                                fontSize: 18,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (session.hasUnreadMessages)
                            Container(
                              margin: const EdgeInsets.only(left: 8),
                              width: 10,
                              height: 10,
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                            ),
                        ],
                      ),
                      subtitle: Text(
                        session.lastMessageText ?? l10n.noMessagesYet,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: Text(
                        formatTime(session.lastMessageTime),
                        style: const TextStyle(color: Colors.grey),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => FullChatScreen(
                              sessionId: session.id,
                              otherUserName: user?.fullName ?? l10n.unknownUser,
                              otherUserImage: user?.profilePictureUrl,
                            ),
                          ),
                        ).then((_) {
                          // Reload sessions when returning to update read status and last message
                          context.read<ChatBloc>().add(LoadChatSessionsEvent());
                        });
                      },
                    );
                  },
                ),
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
