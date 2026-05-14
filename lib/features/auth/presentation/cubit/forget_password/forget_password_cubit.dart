import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../features/auth/data/repo/auth_repo.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  final AuthRepo authRepo;

  ForgetPasswordCubit({required this.authRepo}) : super(ForgetPasswordInitial());

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  Set<String> selectedMethod = {"email"};

  void changeMethod(Set<String> newMethod) {
    selectedMethod = newMethod;
    emit(ForgetPasswordMethodChanged(selectedMethod: selectedMethod));
  }

  Future<void> sendResetCode() async {
    if (!formKey.currentState!.validate()) return;

    final email = selectedMethod.contains("email")
        ? emailController.text.trim()
        : phoneController.text.trim();

    emit(ForgetPasswordLoading());
    try {
      await authRepo.forgotPassword(email: email);
      emit(ForgetPasswordSuccess(
        method: selectedMethod.contains("email") ? "email" : "phone",
        input: email,
      ));
    } on ServerException catch (e) {
      emit(ForgetPasswordFailure(errMessage: e.message));
    } catch (e) {
      emit(ForgetPasswordFailure(errMessage: 'Something went wrong. Please try again.'));
    }
  }

  @override
  Future<void> close() {
    emailController.dispose();
    phoneController.dispose();
    return super.close();
  }
}
