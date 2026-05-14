import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/errors/exceptions.dart';
import '../../../../../../features/auth/data/models/auth_response_model.dart';
import '../../../../../../features/auth/data/repo/auth_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo authRepo;

  AuthCubit({required this.authRepo}) : super(AuthInitial());


  Future<void> signInWithGoogle() async {
    emit(AuthLoading());
    try {
      final result = await authRepo.googleSignIn();
      emit(AuthAuthenticated(user: result));
    } on ServerException catch (e) {
      emit(AuthFailure(message: e.message));
    } catch (e) {
      // Google sign-in cancelled by user
      if (e.toString().contains('cancelled') ||
          e.toString().contains('Google sign-in cancelled')) {
        emit(AuthInitial());
        return;
      }
      emit(AuthFailure(message: 'Google sign-in failed. Please try again.'));
    }
  }


  Future<void> logout() async {
    try {
      await authRepo.logout();
      emit(AuthUnauthenticated());
    } on ServerException catch (e) {
      emit(AuthFailure(message: e.message));
    } catch (e) {
      emit(AuthFailure(message: 'Logout failed. Please try again.'));
    }
  }


  Future<void> checkAuth() async {
    final token = await authRepo.getStoredToken();
    if (token != null) {
      emit(AuthAuthenticated(user: null));
    } else {
      emit(AuthUnauthenticated());
    }
  }
}
