import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../features/auth/data/repo/auth_repo.dart';
part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final AuthRepo authRepo;

  SignInCubit({required this.authRepo}) : super(SignInInitial());

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isPasswordHidden = true;

  void togglePasswordVisibility() {
    isPasswordHidden = !isPasswordHidden;
    emit(SignInPasswordVisibilityChanged(isPasswordHidden: isPasswordHidden));
  }

  Future<void> signIn() async {
    if (!formKey.currentState!.validate()) return;

    emit(SignInLoading());
    try {
      await authRepo.login(
        email: emailController.text.trim(),
        password: passwordController.text,
      );
      emit(SignInSuccess());
    } on ServerException catch (e) {
      emit(SignInFailure(errMessage: e.message));
    } catch (e) {
      emit(SignInFailure(errMessage: 'Something went wrong. Please try again.'));
    }
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }

Future<void> signInWithGoogle() async {
  emit(SignInLoading());

  try {
    await authRepo.googleSignIn();
    emit(SignInSuccess());
  } on ServerException catch (e) {
    emit(SignInFailure(errMessage: e.message));
  } catch (e) {
    emit(SignInFailure(errMessage: 'Something went wrong. Please try again.'));
  }
}
}
