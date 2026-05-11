class SettingsState {
  final bool matchNotification;
  final bool commentsNotification;
  final bool generalNotification;
  final bool smsNotification;

  final bool hidePhone;
  final bool hideLocation;
  final bool postAnonymously;

  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;
  final List<Map<String, dynamic>> activeSessions;

  SettingsState({
    required this.matchNotification,
    required this.commentsNotification,
    required this.generalNotification,
    required this.smsNotification,
    required this.hidePhone,
    required this.hideLocation,
    required this.postAnonymously,
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage,
    this.activeSessions = const [],
  });

  SettingsState copyWith({
    bool? matchNotification,
    bool? commentsNotification,
    bool? generalNotification,
    bool? smsNotification,
    bool? hidePhone,
    bool? hideLocation,
    bool? postAnonymously,
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
    List<Map<String, dynamic>>? activeSessions,
  }) {
    return SettingsState(
      matchNotification: matchNotification ?? this.matchNotification,
      commentsNotification: commentsNotification ?? this.commentsNotification,
      generalNotification: generalNotification ?? this.generalNotification,
      smsNotification: smsNotification ?? this.smsNotification,
      hidePhone: hidePhone ?? this.hidePhone,
      hideLocation: hideLocation ?? this.hideLocation,
      postAnonymously: postAnonymously ?? this.postAnonymously,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage,
      activeSessions: activeSessions ?? this.activeSessions,
    );
  }
}
