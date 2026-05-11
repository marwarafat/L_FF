abstract class SettingsEvent {}

class ToggleMatchNotification extends SettingsEvent {
  final bool value;
  ToggleMatchNotification(this.value);
}

class ToggleCommentsNotification extends SettingsEvent {
  final bool value;
  ToggleCommentsNotification(this.value);
}

class ToggleGeneralNotification extends SettingsEvent {
  final bool value;
  ToggleGeneralNotification(this.value);
}

class ToggleSmsNotification extends SettingsEvent {
  final bool value;
  ToggleSmsNotification(this.value);
}

class ToggleHidePhone extends SettingsEvent {
  final bool value;
  ToggleHidePhone(this.value);
}

class ToggleHideLocation extends SettingsEvent {
  final bool value;
  ToggleHideLocation(this.value);
}

class TogglePostAnonymously extends SettingsEvent {
  final bool value;
  TogglePostAnonymously(this.value);
}

class UpdateProfileEvent extends SettingsEvent {
  final String fullName;
  final String phone;
  final String? profilePicturePath;
  UpdateProfileEvent({required this.fullName, required this.phone, this.profilePicturePath});
}

class ChangePasswordEvent extends SettingsEvent {
  final String currentPassword;
  final String newPassword;
  ChangePasswordEvent({required this.currentPassword, required this.newPassword});
}

class DeleteAccountEvent extends SettingsEvent {
  final String password;
  DeleteAccountEvent({required this.password});
}

class LogoutEvent extends SettingsEvent {
  final String refreshToken;
  LogoutEvent({required this.refreshToken});
}

class LogoutAllDevicesEvent extends SettingsEvent {}

class GetActiveSessionsEvent extends SettingsEvent {}
