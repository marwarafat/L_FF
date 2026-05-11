class ProfileEntity {
  final int id;
  final String fullName;
  final String email;
  final String? phone;
  final String? location;
  final String? memberSince;
  final String? image;
  final String? gender;
  final String? dateOfBirth;
  final bool isVerified;

  ProfileEntity({
    required this.id,
    required this.fullName,
    required this.email,
    this.phone,
    this.location,
    this.memberSince,
    this.image,
    this.gender,
    this.dateOfBirth,
    required this.isVerified,
  });
}
