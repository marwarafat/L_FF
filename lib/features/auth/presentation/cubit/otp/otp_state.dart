part of 'otp_cubit.dart';

abstract class OtpState {}

class OtpInitial extends OtpState {}

class OtpLoading extends OtpState {}

class OtpSuccess extends OtpState {}

class OtpFailure extends OtpState {
  final String errMessage;
  OtpFailure({required this.errMessage});
}

class OtpResendSuccess extends OtpState {}
