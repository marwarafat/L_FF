import '../../../../core/networking/api_keys.dart';

class UserModel {
  final int id;
  final String fullName;
  final String email;
  final String phone;
  final bool isVerified;
  final List<String> roles;
  final String dateOfBirth;
  final String gender;
  final String? profilePictureUrl;
  final String createdAt;
  final String? updatedAt;

  const UserModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.isVerified,
    required this.roles,
    required this.dateOfBirth,
    required this.gender,
    this.profilePictureUrl,
    required this.createdAt,
    this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final fullName = json[ApiKeys.fullName] as String? ??
        '${json['firstName'] ?? ''} ${json['lastName'] ?? ''}'.trim();

    return UserModel(
      id: (json[ApiKeys.id] as num?)?.toInt() ?? 0,
      fullName: fullName,
      email: json[ApiKeys.email] as String? ?? '',
      phone: json[ApiKeys.phone] as String? ?? '',
      isVerified: json['isVerified'] as bool? ?? false,
      roles: (json['roles'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      dateOfBirth: json['dateOfBirth'] as String? ?? '',
      gender: json['gender'] as String? ?? '',
      profilePictureUrl: json['profilePictureUrl'] as String?,
      createdAt: json['createdAt'] as String? ?? '',
      updatedAt: json['updatedAt'] as String?,
    );
  }
}
