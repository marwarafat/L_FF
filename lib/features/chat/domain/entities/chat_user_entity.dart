class ChatUserEntity {
  final int id;
  final String fullName;
  final String? profilePictureUrl;

  ChatUserEntity({
    required this.id,
    required this.fullName,
    this.profilePictureUrl,
  });
}
