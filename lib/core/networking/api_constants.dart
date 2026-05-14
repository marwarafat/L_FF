class ApiConstants {
  static const String baseDomain = "https://wasitkheir.runasp.net";
  static const String baseUrl = "$baseDomain/api/";

  static const String authBase = "auth";

  static const String signup = "$authBase/signup";
  static const String login = "$authBase/login";
  static const String google = "$authBase/google";
  static const String verifyAccount = "$authBase/verify-account";
  static const String refreshToken = "$authBase/refresh-token";
  static const String forgotPassword = "$authBase/forgot-password";
  static const String resetPassword = "$authBase/reset-password";
  static const String changePassword = "$authBase/change-password";
  static const String resendVerification = "$authBase/resend-verification";
  static const String logout = "$authBase/logout";
  static const String me = "$authBase/me";
  static const String deleteAccount = "$authBase/delete-account";
}
