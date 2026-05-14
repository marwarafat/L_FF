part of 'onboarding_cubit.dart';

abstract class OnboardingState {}

class OnboardingInitial extends OnboardingState {}

class OnboardingPageChanged extends OnboardingState {
  final int currentPage;
  OnboardingPageChanged({required this.currentPage});
}

class OnboardingCompleted extends OnboardingState {}
