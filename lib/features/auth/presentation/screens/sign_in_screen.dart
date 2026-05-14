// ignore_for_file: deprecated_member_use

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/constants/app_styles.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/widgets/custom_back_button.dart';
import '../../../../core/widgets/alaa_custom_button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../features/auth/data/repo/auth_repo.dart';
import '../../../../features/auth/presentation/cubit/auth/cubit/auth_cubit.dart';
import '../../../../features/auth/presentation/cubit/sign_in/sign_in_cubit.dart';
import '../../../../features/auth/presentation/screens/widgets/custom_outlined_button.dart';
import '../../../../features/auth/presentation/screens/widgets/sign_or_widget.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => SignInCubit(authRepo: sl<AuthRepo>())),
        BlocProvider(create: (_) => AuthCubit(authRepo: sl<AuthRepo>())),
      ],
      child: const _SignInView(),
    );
  }
}

class _SignInView extends StatelessWidget {
  const _SignInView();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignInCubit>();

    return MultiBlocListener(
      listeners: [
        BlocListener<SignInCubit, SignInState>(
          listener: (context, state) {
            if (state is SignInSuccess) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.mainScreen,
                (route) => false,
              );
            } else if (state is SignInFailure) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text(state.errMessage),
                    backgroundColor: Colors.red,
                  ),
                );
            }
          },
        ),
        BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthAuthenticated) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.mainScreen,
                (route) => false,
              );
            } else if (state is AuthFailure) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red,
                  ),
                );
            }
          },
        ),
      ],
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 29.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 33.h),
                const CustomBackButton(),
                SizedBox(height: 34.h),
                Text(AppLocalizations.of(context)!.welcome_back, style: AppStyles.primary30W800Style),
                Text(
                  AppLocalizations.of(context)!.sign_in_subtitle,
                  style: AppStyles.subTitleTextStyle,
                ),
                SizedBox(height: 72.h),

                Form(
                  key: cubit.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppLocalizations.of(context)!.email, style: AppStyles.black25W400Style),
                      SizedBox(height: 4.h),
                      CustomTextFormField(
                        controller: cubit.emailController,
                        hintText: AppLocalizations.of(context)!.email_hint,
                        prefixIcon: Image.asset(AppImages.emailIcon),
                        prefixIconHeight: 28.h,
                        prefixIconWidth: 37.w,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) return "Email is required";
                          final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                          if (!emailRegex.hasMatch(value.trim())) return "Enter a valid email";
                          return null;
                        },
                      ),
                      SizedBox(height: 15.h),
                      Text(AppLocalizations.of(context)!.password, style: AppStyles.black25W400Style),
                      SizedBox(height: 4.h),
                      BlocBuilder<SignInCubit, SignInState>(
                        buildWhen: (_, curr) => curr is SignInPasswordVisibilityChanged,
                        builder: (context, state) {
                          return CustomTextFormField(
                            controller: cubit.passwordController,
                            isPassword: cubit.isPasswordHidden,
                            hintText: AppLocalizations.of(context)!.password_hint,
                            prefixIcon: Image.asset(AppImages.passwordIcon),
                            prefixIconWidth: 27.w,
                            prefixIconHeight: 27.h,
                            suffixIcon: IconButton(
                              onPressed: cubit.togglePasswordVisibility,
                              icon: Icon(
                                cubit.isPasswordHidden
                                    ? Icons.remove_red_eye_outlined
                                    : Icons.remove_red_eye,
                                color: AppColors.mediumDarkGray,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) return "Password is required";
                              if (value.length < 6) return "Password must be at least 6 characters";
                              return null;
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),

                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    onPressed: () =>
                        Navigator.pushNamed(context, AppRoutes.forgetPasswordScreen),
                    child: Text(AppLocalizations.of(context)!.forgot_password_q, style: AppStyles.primary17W400Style),
                  ),
                ),
                SizedBox(height: 37.h),

                BlocBuilder<SignInCubit, SignInState>(
                  buildWhen: (_, curr) =>
                      curr is SignInLoading ||
                      curr is SignInFailure ||
                      curr is SignInInitial,
                  builder: (context, state) {
                    return AlaaCustomButton(
                      width: 324.w,
                      height: 52.h,
                      buttonText: state is SignInLoading ? "..." : AppLocalizations.of(context)!.sign_in,
                      onPressed: state is SignInLoading ? null : cubit.signIn,
                    );
                  },
                ),

                SizedBox(height: 31.h),
                SignOrWidget(),
                SizedBox(height: 37.h),

                BlocBuilder<AuthCubit, AuthState>(
                  buildWhen: (_, curr) =>
                      curr is AuthLoading ||
                      curr is AuthFailure ||
                      curr is AuthInitial,
                  builder: (context, state) {
                    return CustomOutlinedButton(
                      onPressed: state is AuthLoading
                          ? null
                          : () => context.read<AuthCubit>().signInWithGoogle(),
                      buttonText: state is AuthLoading
                          ? AppLocalizations.of(context)!.connecting
                          : AppLocalizations.of(context)!.continue_with_google,
                      prefixIcon: AppImages.googleIcon,
                    );
                  },
                ),

                SizedBox(height: 18.h),
                Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: AppLocalizations.of(context)!.dont_have_account,
                      style: AppStyles.primary17W400Style
                          .copyWith(color: AppColors.blackColor),
                      children: [
                        TextSpan(
                          text: AppLocalizations.of(context)!.sign_up,
                          style: AppStyles.primary17W400Style,
                          recognizer: TapGestureRecognizer()
                            ..onTap = () =>
                                Navigator.pushNamed(context, AppRoutes.signUpScreen),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 208.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
