class ChangePasswordState {
  final String currentPassword;
  final String newPassword;
  final String confirmPassword;

  final String? currentError;
  final String? newError;
  final String? confirmError;
  final String? serverError;

  final bool isLoading;
  final bool isSuccess;

  const ChangePasswordState({
    this.currentPassword = "",
    this.newPassword = "",
    this.confirmPassword = "",
    this.currentError,
    this.newError,
    this.confirmError,
    this.serverError,
    this.isLoading = false,
    this.isSuccess = false,
  });

  ChangePasswordState copyWith({
    String? currentPassword,
    String? newPassword,
    String? confirmPassword,
    String? currentError,
    String? newError,
    String? confirmError,
    String? serverError,
    bool? isLoading,
    bool? isSuccess,
  }) {
    return ChangePasswordState(
      currentPassword: currentPassword ?? this.currentPassword,
      newPassword: newPassword ?? this.newPassword,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      currentError: currentError,
      newError: newError,
      confirmError: confirmError,
      serverError: serverError,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? false,
    );
  }
}
