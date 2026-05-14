import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/di/service_locator.dart';
import 'app_routes.dart';

// Your existing screen imports
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

// Alaa's screen imports
import '../../features/auth/data/repo/auth_repo.dart';
import '../../features/auth/presentation/cubit/forget_password/forget_password_cubit.dart';
import '../../features/auth/presentation/cubit/otp/otp_cubit.dart';
import '../../features/auth/presentation/cubit/sign_in/sign_in_cubit.dart';
import '../../features/auth/presentation/cubit/sign_up/sign_up_cubit.dart';
import '../../features/auth/presentation/screens/forget_password_screen.dart';
import '../../features/auth/presentation/screens/otp_screen.dart';
import '../../features/auth/presentation/screens/reset_password_screen.dart';
import '../../features/auth/presentation/screens/sign_in_screen.dart';
import '../../features/auth/presentation/screens/sign_up_screen.dart';
import '../../features/home/data/models/dashboard_model.dart';
import '../../features/home/presentation/screens/ai_scanning_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/home/presentation/screens/main_screen.dart';
import '../../features/home/presentation/screens/post_details.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';


class RouterGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // ─── Alaa's Routes ─────────────────────────────────────
      case AppRoutes.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case AppRoutes.onboardingScreen:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());

      case AppRoutes.signInScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => SignInCubit(authRepo: sl<AuthRepo>()),
            child: const SignInScreen(),
          ),
        );

      case AppRoutes.signUpScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => SignUpCubit(authRepo: sl<AuthRepo>()),
            child: const SignUpScreen(),
          ),
        );

      case AppRoutes.forgetPasswordScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => ForgetPasswordCubit(authRepo: sl<AuthRepo>()),
            child: const ForgetPasswordScreen(),
          ),
        );

      case AppRoutes.resetPasswordScreen:
        return MaterialPageRoute(builder: (_) => const ResetPasswordScreen());

      case AppRoutes.homeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case AppRoutes.mainScreen:
        return MaterialPageRoute(builder: (_) => const MainScreen());

      case AppRoutes.postDetails:
        final report = settings.arguments as RecentReportModel;
        return MaterialPageRoute(builder: (_) => PostDetails(report: report));

      case AppRoutes.aiScanScreen:
        return MaterialPageRoute(builder: (_) => const AiScanningScreen());

      case AppRoutes.OtpScreen:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) =>
                OtpCubit(authRepo: sl<AuthRepo>(), email: args?['input'] ?? ''),
            child: const OtpScreen(),
          ),
        );

      // ─── Your Existing Routes ────────────────────────────────
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
