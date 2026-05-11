import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/update_profile_usecase.dart';
import '../../domain/usecases/change_password_usecase.dart';
import '../../domain/usecases/delete_account_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import 'settings_event.dart';
import 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final UpdateProfileUseCase updateProfileUseCase;
  final ChangePasswordUseCase changePasswordUseCase;
  final DeleteAccountUseCase deleteAccountUseCase;
  final LogoutUseCase logoutUseCase;

  SettingsBloc({
    required this.updateProfileUseCase,
    required this.changePasswordUseCase,
    required this.deleteAccountUseCase,
    required this.logoutUseCase,
  }) : super(
          SettingsState(
            matchNotification: true,
            commentsNotification: true,
            generalNotification: true,
            smsNotification: false,
            hidePhone: false,
            hideLocation: true,
            postAnonymously: false,
          ),
        ) {
    on<ToggleMatchNotification>((event, emit) {
      emit(state.copyWith(matchNotification: event.value));
    });

    on<ToggleCommentsNotification>((event, emit) {
      emit(state.copyWith(commentsNotification: event.value));
    });

    on<ToggleGeneralNotification>((event, emit) {
      emit(state.copyWith(generalNotification: event.value));
    });

    on<ToggleSmsNotification>((event, emit) {
      emit(state.copyWith(smsNotification: event.value));
    });

    on<ToggleHidePhone>((event, emit) {
      emit(state.copyWith(hidePhone: event.value));
    });

    on<ToggleHideLocation>((event, emit) {
      emit(state.copyWith(hideLocation: event.value));
    });

    on<TogglePostAnonymously>((event, emit) {
      emit(state.copyWith(postAnonymously: event.value));
    });

    on<UpdateProfileEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true, isSuccess: false));
      try {
        await updateProfileUseCase(
          fullName: event.fullName,
          phone: event.phone,
          profilePicturePath: event.profilePicturePath,
        );
        emit(state.copyWith(isLoading: false, isSuccess: true));
      } catch (e) {
        emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
      }
    });

    on<ChangePasswordEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true, isSuccess: false));
      try {
        await changePasswordUseCase(
          currentPassword: event.currentPassword,
          newPassword: event.newPassword,
        );
        emit(state.copyWith(isLoading: false, isSuccess: true));
      } catch (e) {
        emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
      }
    });

    on<DeleteAccountEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true, isSuccess: false));
      try {
        await deleteAccountUseCase(password: event.password);
        emit(state.copyWith(isLoading: false, isSuccess: true));
      } catch (e) {
        emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
      }
    });

    on<LogoutEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true, isSuccess: false));
      try {
        await logoutUseCase(refreshToken: event.refreshToken);
        emit(state.copyWith(isLoading: false, isSuccess: true));
      } catch (e) {
        emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
      }
    });

    on<LogoutAllDevicesEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true, isSuccess: false));
      try {
        await logoutUseCase(refreshToken: '');
        emit(state.copyWith(isLoading: false, isSuccess: true));
      } catch (e) {
        emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
      }
    });

    on<GetActiveSessionsEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      // Stub: returns empty list until API endpoint is available
      await Future.delayed(const Duration(milliseconds: 300));
      emit(state.copyWith(isLoading: false, activeSessions: const []));
    });
  }
}
