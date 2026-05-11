import '../../domain/entities/chat_user_entity.dart';

class ChatUserModel extends ChatUserEntity {
  ChatUserModel({
    required super.id,
    required super.fullName,
    super.profilePictureUrl,
  });

  factory ChatUserModel.fromJson(Map<String, dynamic> json) {
    return ChatUserModel(
      id: json['id'] ?? 0,
      fullName: json['fullName'] ?? '',
      profilePictureUrl: json['profilePictureUrl'],
    );
  }

  ChatUserEntity toEntity() {
    return ChatUserEntity(
      id: id,
      fullName: fullName,
      profilePictureUrl: profilePictureUrl,
    );
  }
}
