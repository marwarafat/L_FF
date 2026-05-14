import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/app_styles.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../../../core/widgets/alaa_custom_button.dart';
import '../../../../../features/onboarding/presentation/screens/widgets/dot_widget.dart';

class OnboardingWidget extends StatelessWidget {
  final String onboardingText;
  final String onboardingSubText;
  final String image;
  final VoidCallback onSkip;
  final VoidCallback onNext;
  final int currentPage;
  final int totalPages;

  const OnboardingWidget({
    super.key,
    required this.onboardingText,
    required this.onboardingSubText,
    required this.image,
    required this.onSkip,
    required this.onNext,
    required this.currentPage,
    required this.totalPages,
  });

  @override
  Widget build(BuildContext context) {
    final bool isLastPage = currentPage == totalPages - 1;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: TextButton(
              style: ButtonStyle(
                overlayColor: WidgetStateProperty.all(Colors.transparent),
              ),
              onPressed: onSkip,
              child: Text(AppLocalizations.of(context)!.skip, style: AppStyles.platinumGray20W400Style),
            ),
          ),

          const Spacer(),

          Image.asset(image, width: 85.w, height: 92.h, fit: BoxFit.contain),

          SizedBox(height: 32.h),

          Text(
            onboardingText,
            textAlign: TextAlign.center,
            style: AppStyles.titleTextStyle,
          ),

          SizedBox(height: 22.h),

          Text(
            onboardingSubText,
            textAlign: TextAlign.center,
            style: AppStyles.subTitleTextStyle,
          ),

          const Spacer(),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(totalPages, (i) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: (19 / 2).w),
                child: DotWidget(isActive: i == currentPage),
              );
            }),
          ),

          SizedBox(height: 21.h),

          AlaaCustomButton(
            onPressed: onNext,
            buttonText: isLastPage ? AppLocalizations.of(context)!.get_started : AppLocalizations.of(context)!.next,
          ),

          SizedBox(height: 54.h),
        ],
      ),
    );
  }
}
