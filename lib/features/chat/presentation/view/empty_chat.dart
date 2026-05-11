import 'package:flutter/material.dart';
import '../../data/models/chat_session_model.dart';
import 'widgets/chat_appbar.dart';
import 'widgets/message_input.dart';

import '../../../../l10n/app_localizations.dart';

class EmptyChatView extends StatelessWidget {
  final ChatSessionModel chat;

  const EmptyChatView({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomChatAppBar(chat: chat),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.blue.withValues(alpha: 0.2),
                        width: 2,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 45,
                      backgroundImage:
                          chat.otherUser?.profilePictureUrl != null &&
                              chat.otherUser!.profilePictureUrl!.isNotEmpty
                          ? NetworkImage(chat.otherUser!.profilePictureUrl!)
                          : const AssetImage('assets/icons/profile_fill.png')
                                as ImageProvider,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    chat.otherUser?.fullName ??
                        AppLocalizations.of(context)!.unknownUser,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.viewProfile,
                      style: TextStyle(
                        color: Colors.blue[400],
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          CustomInputField(sessionId: chat.id),
        ],
      ),
    );
  }
}
