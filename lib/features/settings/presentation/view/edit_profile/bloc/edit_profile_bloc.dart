import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../profile/domain/usecases/get_user_profile_usecase.dart';
import '../../../../data/models/edit_profile_model.dart';
import '../../../../domain/usecases/update_profile_usecase.dart';
import 'edit_profile_event.dart';
import 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  final GetUserProfileUseCase getUserProfileUseCase;
  final UpdateProfileUseCase updateProfileUseCase;

  EditProfileBloc({
    required this.getUserProfileUseCase,
    required this.updateProfileUseCase,
  }) : super(EditProfileState()) {
    on<LoadProfile>(_loadProfile);
    on<UpdateName>(_updateName);
    on<UpdatePhone>(_updatePhone);
    on<UpdateEmail>(_updateEmail);
    on<UpdateCity>(_updateCity);
    on<SaveProfile>(_saveProfile);
  }

  Future<void> _loadProfile(
    LoadProfile event,
    Emitter<EditProfileState> emit,
  ) async {
    emit(state.copyWith(loading: true));
    try {
      final profile = await getUserProfileUseCase();
      emit(
        state.copyWith(
          loading: false,
          profile: EditProfileModel(
            name: profile.fullName,
            phone: profile.phone ?? '',
            email: profile.email,
            location: profile.location ?? '',
          ),
          errorMessage: null,
        ),
      );
    } catch (e) {
      emit(state.copyWith(loading: false, errorMessage: e.toString()));
    }
  }

  void _updateName(UpdateName event, Emitter<EditProfileState> emit) {
    if (state.profile != null) {
      emit(
        state.copyWith(
          profile: state.profile!.copyWith(name: event.name),
          errorMessage: null,
        ),
      );
    }
  }

  void _updatePhone(UpdatePhone event, Emitter<EditProfileState> emit) {
    if (state.profile != null) {
      emit(
        state.copyWith(
          profile: state.profile!.copyWith(phone: event.phone),
          errorMessage: null,
        ),
      );
    }
  }

  void _updateEmail(UpdateEmail event, Emitter<EditProfileState> emit) {
    if (state.profile != null) {
      emit(
        state.copyWith(
          profile: state.profile!.copyWith(email: event.email),
          errorMessage: null,
        ),
      );
    }
  }

  void _updateCity(UpdateCity event, Emitter<EditProfileState> emit) {
    if (state.profile != null) {
      emit(
        state.copyWith(
          profile: state.profile!.copyWith(location: event.city),
          errorMessage: null,
        ),
      );
    }
  }

  Future<void> _saveProfile(
    SaveProfile event,
    Emitter<EditProfileState> emit,
  ) async {
    final p = state.profile;

    // Validation
    if (p == null || p.name.trim().isEmpty || p.phone.trim().isEmpty) {
      emit(
        state.copyWith(
          errorMessage: "Name and phone are required!",
          isSuccess: false,
        ),
      );
      return;
    }

    if (p.phone.length < 11) {
      emit(
        state.copyWith(errorMessage: "Phone number must be at least 11 digits"),
      );
      return;
    }

    emit(state.copyWith(loading: true, errorMessage: null, isSuccess: false));
    try {
      await updateProfileUseCase(
        fullName: p.name.trim(),
        phone: p.phone.trim(),
        location: p.location.trim(),
      );
      emit(state.copyWith(loading: false, isSuccess: true));
    } catch (e) {
      String message = e.toString();
      // Extract meaningful message from Exception
      if (message.startsWith('Exception: ')) {
        message = message.substring(11);
      }
      emit(state.copyWith(loading: false, errorMessage: message));
    }
  }
}
