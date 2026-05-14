import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/constants/app_styles.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../features/onboarding/presentation/cubit/onboarding_cubit.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OnboardingCubit()..checkOnboardingStatus(),
      child: const _SplashView(),
    );
  }
}

class _SplashView extends StatelessWidget {
  const _SplashView();

  @override
  Widget build(BuildContext context) {
    return BlocListener<OnboardingCubit, OnboardingState>(
      listener: (context, state) {
        if (state is OnboardingCompleted) {
          Navigator.pushReplacementNamed(context, AppRoutes.signInScreen);
        } else if (state is OnboardingInitial) {
          Navigator.pushReplacementNamed(context, AppRoutes.onboardingScreen);
        }
      },
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(AppImages.logo, width: 310.w, height: 310.h),
            ),
            Text("Wassit Khier", style: AppStyles.primary30W800Style),
          ],
        ),
      ),
    );
  }
}
