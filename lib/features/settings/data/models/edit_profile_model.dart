class EditProfileModel {
  final String name;
  final String email;
  final String location;
  final String phone;

  EditProfileModel({
    required this.name,
    required this.email,
    required this.location,
    required this.phone,
  });

  factory EditProfileModel.fromJson(Map<String, dynamic> json) {
    return EditProfileModel(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      location: json['location'] ?? '',
      phone: json['phone'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'email': email, 'location': location, 'phone': phone};
  }

  EditProfileModel copyWith({
    String? name,
    String? phone,
    String? email,
    String? location,
  }) {
    return EditProfileModel(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      location: location ?? this.location,
    );
  }
}
