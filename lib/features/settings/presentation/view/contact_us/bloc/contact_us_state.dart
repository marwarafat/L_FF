class ContactState {
  final bool loading;
  final String subject;
  final String message;
  final String? error;
  final bool success;

  ContactState({
    this.loading = false,
    this.subject = '',
    this.message = '',
    this.error,
    this.success = false,
  });

  ContactState copyWith({
    bool? loading,
    String? subject,
    String? message,
    String? error,
    bool? success,
  }) {
    return ContactState(
      loading: loading ?? this.loading,
      subject: subject ?? this.subject,
      message: message ?? this.message,
      error: error,
      success: success ?? this.success,
    );
  }
}
