import 'package:flutter/material.dart';
import 'core/storage/token_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/routing/app_routes.dart';
import 'core/routing/router_generator.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';
import 'core/localization/locale_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();

  String accessToken =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6IjEiLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiV2FzaXQgS2hlaXIgQWRtaW4iLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9lbWFpbGFkZHJlc3MiOiJsb3N0LmZvdW5kMjAyNkBnbWFpbC5jb20iLCJJc1ZlcmlmaWVkIjoiVHJ1ZSIsImp0aSI6IjIxYjg1MzVkLWMzNzctNDU3Mi1iZmUwLTVjODQ1YWZmNDYxOSIsImlhdCI6MTc3ODQ3MzY4MCwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9yb2xlIjoiQWRtaW4iLCJleHAiOjE3Nzg0NzcyODAsImlzcyI6Ikxvc3RBbmRGb3VuZC5BcGkiLCJhdWQiOiJMb3N0QW5kRm91bmQuQ2xpZW50In0.0nPdJEbuMnJAGQodqTyo_kN672J5aBPKgeeIWGULBnY";
  await CacheHelper.saveData(key: "token", value: accessToken);

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
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Lost & Found',
            locale: locale,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [Locale('en'), Locale('ar')],
            initialRoute: AppRoutes.reportItem,
            onGenerateRoute: RouterGenerator.generateRoute,
          );
        },
      ),
    );
  }
}
