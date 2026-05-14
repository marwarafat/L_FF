import '../../../../core/networking/api_constants.dart';
import '../../domain/entities/chat_user_entity.dart';

class ChatUserModel extends ChatUserEntity {
  ChatUserModel({
    required super.id,
    required super.fullName,
    super.profilePictureUrl,
  });

  factory ChatUserModel.fromJson(Map<String, dynamic> json) {
    String? imageUrl = json['profilePictureUrl'];
    if (imageUrl != null && !imageUrl.startsWith('http')) {
      imageUrl = '${ApiConstants.baseDomain}$imageUrl';
    }
    return ChatUserModel(
      id: json['id'] ?? 0,
      fullName: json['fullName'] ?? '',
      profilePictureUrl: imageUrl,
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
