abstract class ChangePasswordEvent {}

class CurrentPasswordChanged extends ChangePasswordEvent {
  final String value;
  CurrentPasswordChanged(this.value);
}

class NewPasswordChanged extends ChangePasswordEvent {
  final String value;
  NewPasswordChanged(this.value);
}

class ConfirmPasswordChanged extends ChangePasswordEvent {
  final String value;
  ConfirmPasswordChanged(this.value);
}

class SubmitChangePassword extends ChangePasswordEvent {}
