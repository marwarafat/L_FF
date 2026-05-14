part of 'sign_in_cubit.dart';

abstract class SignInState {}

class SignInInitial extends SignInState {}

class SignInLoading extends SignInState {}

class SignInSuccess extends SignInState {}

class SignInFailure extends SignInState {
  final String errMessage;
  SignInFailure({required this.errMessage});
}

class SignInPasswordVisibilityChanged extends SignInState {
  final bool isPasswordHidden;
  SignInPasswordVisibilityChanged({required this.isPasswordHidden});
}
