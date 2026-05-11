class EndPoints {
  static const String users = "/Users";
  static const String currentUser = "/Users/me";
  static const String reports = "/Reports";
  static const String myReports = "/reports/my-reports";
  static const String notifications = "/Notifications";
  static const String unreadCount = "/Notifications/unread";
  static const String markAllRead = "/Notifications/mark-all-read";
  static const String markRead = "/Notifications"; // + /{id}/read
  static const String registerDevice = "/Notifications/register-device";

  static const String chat = "/chat";

  // Auth
  static const String changePassword = "/auth/change-password";
  static const String logout = "/auth/logout";
  static const String deleteAccount = "/auth/delete-account";

  // Categories
  static const String categoriesMapping = "/Categories/mapping";

  // Reports
  static const String createReport = "/Reports";
}
