import 'chat_user_entity.dart';

class ChatMessageEntity {
  final int id;
  final int chatSessionId;
  final int senderId;
  final int receiverId;
  final String text;
  final String sentAt;
  final bool isRead;
  final ChatUserEntity? sender;
  final ChatUserEntity? receiver;

  ChatMessageEntity({
    required this.id,
    required this.chatSessionId,
    required this.senderId,
    required this.receiverId,
    required this.text,
    required this.sentAt,
    required this.isRead,
    this.sender,
    this.receiver,
  });
}
