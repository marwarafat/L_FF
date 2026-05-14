part of 'forget_password_cubit.dart';

abstract class ForgetPasswordState {}

class ForgetPasswordInitial extends ForgetPasswordState {}

class ForgetPasswordLoading extends ForgetPasswordState {}

class ForgetPasswordSuccess extends ForgetPasswordState {
  final String method;
  final String input;
  ForgetPasswordSuccess({required this.method, required this.input});
}

class ForgetPasswordFailure extends ForgetPasswordState {
  final String errMessage;
  ForgetPasswordFailure({required this.errMessage});
}

class ForgetPasswordMethodChanged extends ForgetPasswordState {
  final Set<String> selectedMethod;
  ForgetPasswordMethodChanged({required this.selectedMethod});
}
