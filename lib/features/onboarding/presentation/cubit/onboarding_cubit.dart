import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(OnboardingInitial());

  static const String _onboardingKey = 'is_onboarding_done';

  final PageController pageController = PageController();
  final int totalPages = 3;
  int currentPage = 0;

  Future<void> checkOnboardingStatus() async {
    await Future.delayed(const Duration(seconds: 3));
    final done = await isOnboardingDone();
    if (done) {
      emit(OnboardingCompleted()); 
    } else {
      emit(OnboardingInitial());  
    }
  }

  void onPageChanged(int index) {
    currentPage = index;
    emit(OnboardingPageChanged(currentPage: index));
  }

  void nextPage() {
    if (currentPage < totalPages - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      completeOnboarding();
    }
  }

  void skip() {
    completeOnboarding();
  }

  Future<void> completeOnboarding() async {
    await _saveOnboardingDone();
    emit(OnboardingCompleted());
  }


  Future<void> _saveOnboardingDone() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardingKey, true);
  }

  static Future<bool> isOnboardingDone() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_onboardingKey) ?? false;
  }

  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }
}
