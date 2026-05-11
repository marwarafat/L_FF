import '../../../../data/models/edit_profile_model.dart';

class EditProfileState {
  final bool loading;
  final EditProfileModel? profile;
  final String? errorMessage; // حقل جديد للرسائل
  final bool isSuccess; // حقل جديد

  EditProfileState({
    this.loading = false,
    this.profile,
    this.errorMessage,
    this.isSuccess = false,
  });

  EditProfileState copyWith({
    bool? loading,
    EditProfileModel? profile,
    String? errorMessage,
    bool? isSuccess,
  }) {
    return EditProfileState(
      loading: loading ?? this.loading,
      profile: profile ?? this.profile,
      errorMessage: errorMessage, // نمرره مباشرة للسماح بتصفيره (null)
      isSuccess: isSuccess ?? false, // بنخليها false لو مبعتناش قيمتها
    );
  }
}
