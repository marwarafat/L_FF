part of 'sign_up_cubit.dart';

abstract class SignUpState {}

class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpSuccess extends SignUpState {}

class SignUpFailure extends SignUpState {
  final String errMessage;
  SignUpFailure({required this.errMessage});
}

class SignUpPasswordVisibilityChanged extends SignUpState {
  final bool isPasswordHidden;
  SignUpPasswordVisibilityChanged({required this.isPasswordHidden});
}

class SignUpDateChanged extends SignUpState {
  final String date;
  SignUpDateChanged({required this.date});
}

class SignUpGenderChanged extends SignUpState {
  final String gender;
  SignUpGenderChanged({required this.gender});
}
