import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../features/onboarding/presentation/cubit/onboarding_cubit.dart';
import '../../../../features/onboarding/presentation/screens/widgets/onboarding_widget.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OnboardingCubit(),
      child: const _OnboardingView(),
    );
  }
}

class _OnboardingView extends StatelessWidget {
  const _OnboardingView();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OnboardingCubit>();

    return BlocListener<OnboardingCubit, OnboardingState>(
      listener: (context, state) {
        if (state is OnboardingCompleted) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.signInScreen,
            (route) => false, 
          );
        }
      },
      child: SafeArea(
        child: Scaffold(
          body: BlocBuilder<OnboardingCubit, OnboardingState>(
            buildWhen: (prev, curr) => curr is OnboardingPageChanged,
            builder: (context, state) {
              return PageView(
                controller: cubit.pageController,
                onPageChanged: cubit.onPageChanged,
                children: [
                  OnboardingWidget(
                    onboardingText: AppLocalizations.of(context)!.onboarding_title_1,
                    onboardingSubText: AppLocalizations.of(context)!.onboarding_subtitle_1,
                    image: AppImages.onboardingOneIcon,
                    onNext: cubit.nextPage,
                    onSkip: cubit.skip,
                    currentPage: cubit.currentPage,
                    totalPages: cubit.totalPages,
                  ),
                  OnboardingWidget(
                    onboardingText: AppLocalizations.of(context)!.onboarding_title_2,
                    onboardingSubText: AppLocalizations.of(context)!.onboarding_subtitle_2,
                    image: AppImages.onboardingTwoIcon,
                    onNext: cubit.nextPage,
                    onSkip: cubit.skip,
                    currentPage: cubit.currentPage,
                    totalPages: cubit.totalPages,
                  ),
                  OnboardingWidget(
                    onboardingText: AppLocalizations.of(context)!.onboarding_title_3,
                    onboardingSubText: AppLocalizations.of(context)!.onboarding_subtitle_3,
                    image: AppImages.onboardingThreeIcon,
                    onNext: cubit.nextPage,
                    onSkip: cubit.skip,
                    currentPage: cubit.currentPage,
                    totalPages: cubit.totalPages,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
