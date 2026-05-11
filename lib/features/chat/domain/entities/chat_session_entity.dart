import 'chat_user_entity.dart';

class ChatSessionEntity {
  final int id;
  final ChatUserEntity? otherUser;
  final String? lastMessageText;
  final String? lastMessageTime;
  final bool hasUnreadMessages;

  ChatSessionEntity({
    required this.id,
    this.otherUser,
    this.lastMessageText,
    this.lastMessageTime,
    required this.hasUnreadMessages,
  });
}
