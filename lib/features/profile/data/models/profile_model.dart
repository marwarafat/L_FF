import '../../domain/entities/profile_entity.dart';

class ProfileModel extends ProfileEntity {
  ProfileModel({
    required super.id,
    required super.fullName,
    required super.email,
    super.phone,
    super.location,
    super.memberSince,
    super.image,
    super.gender,
    super.dateOfBirth,
    required super.isVerified,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    String? createdAt = json['createdAt'];
    String? formattedDate;
    if (createdAt != null) {
      DateTime date = DateTime.parse(createdAt);
      formattedDate = "${_monthName(date.month)} ${date.year}";
    }

    return ProfileModel(
      id: json['id'] ?? 0,
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'],
      location: json['location'],
      memberSince: formattedDate,
      image: json['profilePictureUrl'],
      gender: json['gender'],
      dateOfBirth: json['dateOfBirth'],
      isVerified: json['isVerified'] ?? false,
    );
  }

  static String _monthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return month >= 1 && month <= 12 ? months[month - 1] : '';
  }
}
