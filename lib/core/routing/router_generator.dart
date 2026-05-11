import 'package:flutter/material.dart';

import 'app_routes.dart';
import '../../features/profile/presentation/view/profile_screen.dart';
import '../../features/notification/presentation/view/notifications_screen.dart';
import '../../features/chat/presentation/view/chat_list_screen.dart';
import '../../features/chat/presentation/view/full_chat_screen.dart';
import '../../features/report/presentation/view/report_item_view.dart';
import '../../features/settings/presentation/view/settings_screen.dart';
import '../../features/settings/presentation/view/edit_profile/edit_profile.dart';
import '../../features/settings/presentation/view/change_password/change_password.dart';
import '../../features/settings/presentation/view/contact_us/contact_us.dart';
import '../../features/settings/presentation/view/report_abuse/report_abuse.dart';
import '../../features/settings/presentation/view/widgets/privacy_policy.dart';
import '../../features/settings/presentation/view/widgets/teams_conditions.dart';

class RouterGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.login:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text("Login Screen"))),
        );

      case AppRoutes.settings:
        return MaterialPageRoute(builder: (_) => const SettingsScreen());

      case AppRoutes.profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());

      case AppRoutes.notifications:
        return MaterialPageRoute(builder: (_) => const NotificationsScreen());

      case AppRoutes.chatList:
        return MaterialPageRoute(builder: (_) => const ChatListScreen());

      case AppRoutes.fullChat:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => FullChatScreen(
            sessionId: args['sessionId'],
            otherUserName: args['otherUserName'],
            otherUserImage: args['otherUserImage'],
          ),
        );

      case AppRoutes.reportItem:
        return MaterialPageRoute(builder: (_) => const ReportItemView());

      case AppRoutes.editProfile:
        return MaterialPageRoute(
          builder: (_) => const ProfileInformationScreen(),
        );

      case AppRoutes.changePassword:
        return MaterialPageRoute(builder: (_) => const ChangePasswordScreen());

      case AppRoutes.contactUs:
        return MaterialPageRoute(builder: (_) => const ContactUsScreen());

      case AppRoutes.reportAbuse:
        return MaterialPageRoute(builder: (_) => const ReportAbuse());

      case AppRoutes.privacyPolicy:
        return MaterialPageRoute(builder: (_) => const PrivacyPolicy());

      case AppRoutes.termsConditions:
        return MaterialPageRoute(builder: (_) => const TermsConditions());

      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('NO ROUTES FOUND'))),
        );
    }
  }
}
