import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_styles.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/widgets/custom_back_button.dart';
import '../../../../core/widgets/alaa_custom_button.dart';
import '../../../../features/auth/data/repo/auth_repo.dart';
import '../../../../features/auth/presentation/cubit/otp/otp_cubit.dart';
import '../../../../l10n/app_localizations.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;

    return BlocProvider(
      create: (_) => OtpCubit(authRepo: sl<AuthRepo>(), email: args['input']),
      child: const _OtpView(),
    );
  }
}

class _OtpView extends StatelessWidget {
  const _OtpView();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OtpCubit>();

    return BlocListener<OtpCubit, OtpState>(
      listener: (context, state) {
        if (state is OtpSuccess) {
          Navigator.pushNamed(context, AppRoutes.signInScreen);
        } else if (state is OtpResendSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Code resent successfully")),
          );
        } else if (state is OtpFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errMessage),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(34.0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomBackButton(arrowColor: AppColors.lightGray),
              SizedBox(height: 49.h),
              Text(
                AppLocalizations.of(context)!.enter_verification_code,
                style: AppStyles.primary30W800Style,
              ),
              Text(
                AppLocalizations.of(context)!.otp_subtitle,
                style: AppStyles.subTitleTextStyle.copyWith(fontSize: 17.sp),
              ),
              SizedBox(height: 49.h),

              Center(
                child: Pinput(
                  length: 6,
                  onChanged: cubit.onOtpChanged,
                  defaultPinTheme: PinTheme(
                    width: 47.w,
                    height: 49.h,
                    textStyle: TextStyle(
                      fontSize: 22.sp,
                      color: Colors.black,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(color: AppColors.primaryColor),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 33.h),
              Center(
                child: TextButton(
                  onPressed: cubit.resendCode,
                  child: Text(
                    AppLocalizations.of(context)!.resend_code,
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 18.sp,
                      fontWeight: const FontWeight(800),
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.primaryColor,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 72.h),

              BlocBuilder<OtpCubit, OtpState>(
                buildWhen: (prev, curr) =>
                    curr is OtpLoading ||
                    curr is OtpFailure ||
                    curr is OtpInitial,
                builder: (context, state) {
                  return Center(
                    child: AlaaCustomButton(
                      width: 328.w,
                      height: 52.h,
                      buttonText: state is OtpLoading
                          ? "..."
                          : AppLocalizations.of(context)!.verify_code,
                      onPressed: state is OtpLoading ? null : cubit.verifyOtp,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
