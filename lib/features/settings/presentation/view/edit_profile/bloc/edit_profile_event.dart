abstract class EditProfileEvent {}

class LoadProfile extends EditProfileEvent {}

class UpdateName extends EditProfileEvent {
  final String name;
  UpdateName(this.name);
}

class UpdatePhone extends EditProfileEvent {
  final String phone;
  UpdatePhone(this.phone);
}

class UpdateEmail extends EditProfileEvent {
  final String email;
  UpdateEmail(this.email);
}

class UpdateCity extends EditProfileEvent {
  final String city;
  UpdateCity(this.city);
}

class SaveProfile extends EditProfileEvent {}
