import '../../domain/entities/chat_message_entity.dart';
import 'chat_user_model.dart';

class ChatMessageModel extends ChatMessageEntity {
  ChatMessageModel({
    required super.id,
    required super.chatSessionId,
    required super.senderId,
    required super.receiverId,
    required super.text,
    required super.sentAt,
    required super.isRead,
    super.sender,
    super.receiver,
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      id: json['id'] ?? 0,
      chatSessionId: json['chatSessionId'] ?? 0,
      senderId: json['senderId'] ?? 0,
      receiverId: json['receiverId'] ?? 0,
      text: json['text'] ?? '',
      sentAt: json['sentAt'] ?? '',
      isRead: json['isRead'] ?? false,
      sender: json['sender'] != null
          ? ChatUserModel.fromJson(json['sender'])
          : null,
      receiver: json['receiver'] != null
          ? ChatUserModel.fromJson(json['receiver'])
          : null,
    );
  }

  ChatMessageEntity toEntity() {
    return ChatMessageEntity(
      id: id,
      chatSessionId: chatSessionId,
      senderId: senderId,
      receiverId: receiverId,
      text: text,
      sentAt: sentAt,
      isRead: isRead,
      sender: (sender as ChatUserModel?)?.toEntity(),
      receiver: (receiver as ChatUserModel?)?.toEntity(),
    );
  }
}
