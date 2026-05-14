import 'package:flutter/material.dart';
import 'core/storage/token_storage.dart';
import 'core/utils/token_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/routing/app_routes.dart';
import 'core/routing/router_generator.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/di/service_locator.dart';
import 'core/constants/theme_data.dart';
import 'firebase_options.dart';
import 'core/localization/locale_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  await CacheHelper.init();
  setupServiceLocator();
  
  // Sync tokens between Storage systems
  final tokenStorage = sl<TokenStorage>();
  
  // 1. Sync FROM CacheHelper TO TokenStorage (if new storage is empty)
  final oldToken = CacheHelper.getData(key: "token");
  final currentToken = await tokenStorage.getAccessToken();
  if (oldToken != null && currentToken == null) {
    print("DEBUG: Syncing old token from SharedPreferences to SecureStorage");
    await tokenStorage.saveTokens(oldToken, ""); // Refresh token might be missing but access token is enough for now
  }

  // 2. Sync FROM TokenStorage TO CacheHelper (for features still using old system)
  final accessToken = await tokenStorage.getAccessToken();
  if (accessToken != null) {
    await CacheHelper.saveData(key: "token", value: accessToken);
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LocaleCubit(),
      child: BlocBuilder<LocaleCubit, Locale>(
        builder: (context, locale) {
          return ScreenUtilInit(
            designSize: const Size(412, 917),
            builder: (context, child) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Lost & Found',
                theme: AppThemes.ligthTheme,
                locale: locale,
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: const [Locale('en'), Locale('ar')],
                initialRoute: AppRoutes.splashScreen,
                onGenerateRoute: RouterGenerator.generateRoute,
              );
            },
          );
        },
      ),
    );
  }
}
