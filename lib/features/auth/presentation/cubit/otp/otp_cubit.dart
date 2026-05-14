import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../features/auth/data/repo/auth_repo.dart';

part 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  final AuthRepo authRepo;
  final String email; 

  OtpCubit({required this.authRepo, required this.email}) : super(OtpInitial());

  String _otp = '';

  void onOtpChanged(String value) {
    _otp = value;
  }

  Future<void> verifyOtp() async {
    if (_otp.length < 6) return;

    emit(OtpLoading());
    try {
      await authRepo.verifyAccount(email: email, code: _otp);
      emit(OtpSuccess());
    } on ServerException catch (e) {
      emit(OtpFailure(errMessage: e.message));
    } catch (e) {
      emit(OtpFailure(errMessage: 'Something went wrong. Please try again.'));
    }
  }

  Future<void> resendCode() async {
    try {
      await authRepo.resendVerification(email: email);
      emit(OtpResendSuccess());
    } on ServerException catch (e) {
      emit(OtpFailure(errMessage: e.message));
    } catch (e) {
      emit(OtpFailure(errMessage: 'Failed to resend code.'));
    }
  }
}
