import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/constants/app_styles.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/widgets/custom_back_button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/widgets/alaa_custom_button.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    final method = args?['method'] ?? 'email';
    final input = args?['input'] ?? '';

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(34.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomBackButton(arrowColor: AppColors.lightGray),
            SizedBox(height: 29.h),
            Text(
              AppLocalizations.of(context)!.check_your_email,
              style: AppStyles.primary30W800Style,
            ),
            SizedBox(height: 11.h),
            Text(
              AppLocalizations.of(context)!.reset_link_sent_email(input),
              style: AppStyles.subTitleTextStyle.copyWith(fontSize: 18.sp),
            ),
            SizedBox(height: 42.h),
            Stack(
              children: [
                Container(
                  width: 353.w,
                  height: 171.h,
                  decoration: BoxDecoration(
                    color: AppColors.lightBlueColor,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                ),
                Positioned(
                  top: 21.h,
                  bottom: 74.h,
                  right: 133.w,
                  child: Image.asset(
                    AppImages.emailImage,
                    width: 76.w,
                    height: 76.h,
                  ),
                ),
                Positioned(
                  top: 127.h,
                  left: 80.w,
                  child: Text(
                    AppLocalizations.of(context)!.reset_link_success,
                    style: AppStyles.primary17W400Style,
                  ),
                ),
              ],
            ),
            SizedBox(height: 89.h),
            Center(
              child: AlaaCustomButton(
                width: 328.w,
                height: 52.h,
                buttonText: AppLocalizations.of(context)!.enter_otp,
                onPressed: () => Navigator.pushNamed(
                  context,
                  AppRoutes.OtpScreen,
                  arguments: {"input": input},
                ),
              ),
            ),
            SizedBox(height: 21.h),
            InkWell(
              onTap: () =>
                  Navigator.pushNamed(context, AppRoutes.signInScreen),
              borderRadius: BorderRadius.circular(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomBackButton(arrowColor: AppColors.primaryColor),
                  SizedBox(width: 5.w),
                  Text(
                    AppLocalizations.of(context)!.back_to_login,
                    style:
                        AppStyles.primary17W400Style.copyWith(fontSize: 20.sp),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
