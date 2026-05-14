// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_styles.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/widgets/custom_back_button.dart';
import '../../../../core/widgets/alaa_custom_button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../features/auth/data/repo/auth_repo.dart';
import '../../../../features/auth/presentation/cubit/forget_password/forget_password_cubit.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ForgetPasswordCubit(authRepo: sl<AuthRepo>()),
      child: const _ForgetPasswordView(),
    );
  }
}

class _ForgetPasswordView extends StatelessWidget {
  const _ForgetPasswordView();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ForgetPasswordCubit>();

    return BlocListener<ForgetPasswordCubit, ForgetPasswordState>(
      listener: (context, state) {
        if (state is ForgetPasswordSuccess) {
          Navigator.pushNamed(
            context,
            AppRoutes.resetPasswordScreen,
            arguments: {"method": state.method, "input": state.input},
          );
        } else if (state is ForgetPasswordFailure) {
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
          child: Form(
            key: cubit.formKey,
            child: BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
              builder: (context, state) {
                final selectedMethod = cubit.selectedMethod;
                final isEmail = selectedMethod.contains("email");

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomBackButton(arrowColor: AppColors.lightGray),
                    SizedBox(height: 30.h),
                    Text(
                      AppLocalizations.of(context)!.forgot_password_title,
                      style: AppStyles.primary30W800Style,
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      AppLocalizations.of(context)!.forgot_password_subtitle,
                      style: AppStyles.black25W400Style.copyWith(
                        fontSize: 18.sp,
                      ),
                    ),
                    SizedBox(height: 29.h),

                    // EMAIL ONLY
                    Text(AppLocalizations.of(context)!.email_address, style: AppStyles.black25W400Style),
                    SizedBox(height: 10.h),

                    CustomTextFormField(
                      controller: cubit.emailController,
                      height: 45,
                      hintText: AppLocalizations.of(context)!.email_hint,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Email is required";
                        }
                        final emailRegex = RegExp(
                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                        );
                        if (!emailRegex.hasMatch(value.trim())) {
                          return "Enter a valid email";
                        }
                        return null;
                      },
                    ),

                    Text(
                      "    " + AppLocalizations.of(context)!.we_send_otp_to_email,
                      style: AppStyles.subTitleTextStyle.copyWith(
                        fontSize: 18.sp,
                      ),
                    ),

                    SizedBox(height: 80.h),

                    Align(
                      alignment: Alignment.center,
                      child: AlaaCustomButton(
                        width: 290.w,
                        buttonText: state is ForgetPasswordLoading
                            ? "..."
                            : AppLocalizations.of(context)!.send_reset_code,
                        onPressed: state is ForgetPasswordLoading
                            ? null
                            : cubit.sendResetCode,
                      ),
                    ),

                    SizedBox(height: 30.h),

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
                            style: AppStyles.primary17W400Style.copyWith(
                              fontSize: 20.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
