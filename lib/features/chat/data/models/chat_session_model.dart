import '../../domain/entities/chat_session_entity.dart';
import 'chat_user_model.dart';

class ChatSessionModel extends ChatSessionEntity {
  ChatSessionModel({
    required super.id,
    super.otherUser,
    super.lastMessageText,
    super.lastMessageTime,
    required super.hasUnreadMessages,
  });

  factory ChatSessionModel.fromJson(Map<String, dynamic> json) {
    final lastMessage = json['lastMessage'];
    return ChatSessionModel(
      id: json['id'] ?? 0,
      otherUser: json['otherUser'] != null
          ? ChatUserModel.fromJson(json['otherUser'])
          : null,
      lastMessageText: lastMessage != null ? lastMessage['text'] : null,
      lastMessageTime: json['lastMessageTime'],
      hasUnreadMessages: json['hasUnreadMessages'] ?? false,
    );
  }

  ChatSessionEntity toEntity() {
    return ChatSessionEntity(
      id: id,
      otherUser: (otherUser as ChatUserModel?)?.toEntity(),
      lastMessageText: lastMessageText,
      lastMessageTime: lastMessageTime,
      hasUnreadMessages: hasUnreadMessages,
    );
  }
}
