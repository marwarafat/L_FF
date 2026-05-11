import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/usecases/change_password_usecase.dart';
import 'change_password_event.dart';
import 'change_password_state.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  final ChangePasswordUseCase _changePasswordUseCase;

  ChangePasswordBloc({required ChangePasswordUseCase changePasswordUseCase})
    : _changePasswordUseCase = changePasswordUseCase,
      super(const ChangePasswordState()) {
    on<CurrentPasswordChanged>((event, emit) {
      emit(state.copyWith(currentPassword: event.value, currentError: null));
    });

    on<NewPasswordChanged>((event, emit) {
      emit(state.copyWith(newPassword: event.value, newError: null));
    });

    on<ConfirmPasswordChanged>((event, emit) {
      emit(state.copyWith(confirmPassword: event.value, confirmError: null));
    });

    on<SubmitChangePassword>((event, emit) async {
      // --- Local Validation ---
      if (state.currentPassword.isEmpty) {
        emit(state.copyWith(currentError: "Enter current password"));
        return;
      }

      if (state.newPassword.length < 6) {
        emit(
          state.copyWith(newError: "Password must be at least 6 characters"),
        );
        return;
      }

      if (state.newPassword != state.confirmPassword) {
        emit(state.copyWith(confirmError: "Passwords do not match"));
        return;
      }

      // --- API Call ---
      emit(state.copyWith(isLoading: true));
      try {
        await _changePasswordUseCase(
          currentPassword: state.currentPassword,
          newPassword: state.newPassword,
        );
        emit(state.copyWith(isLoading: false, isSuccess: true));
      } catch (e) {
        String message = e.toString();
        if (message.startsWith('Exception: ')) {
          message = message.substring(11);
        }
        emit(state.copyWith(isLoading: false, serverError: message));
      }
    });
  }
}
