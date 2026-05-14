class EndPoints {
  static const String users = "users";
  static const String currentUser = "auth/me";
  static const String reports = "reports";
  static const String myReports = "reports/my-reports";
  static const String notifications = "notifications";
  static const String unreadCount = "notifications/unread";
  static const String markAllRead = "notifications/mark-all-read";
  static const String markRead = "notifications"; // + /{id}/read
  static const String registerDevice = "notifications/register-device";

  static const String chat = "chat";

  // Auth
  static const String changePassword = "auth/change-password";
  static const String logout = "auth/logout";
  static const String deleteAccount = "auth/delete-account";

  // Categories
  static const String categoriesMapping = "categories/mapping";

  // Reports
  static const String createReport = "reports";
}
