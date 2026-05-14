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
import '../../../../features/auth/presentation/cubit/sign_up/sign_up_cubit.dart';
import '../../../../features/auth/presentation/screens/widgets/custom_outlined_button.dart';
import '../../../../features/auth/presentation/screens/widgets/sign_or_widget.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => SignUpCubit(authRepo: sl<AuthRepo>())),
        BlocProvider(create: (_) => AuthCubit(authRepo: sl<AuthRepo>())),
      ],
      child: const _SignUpView(),
    );
  }
}

class _SignUpView extends StatelessWidget {
  const _SignUpView();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignUpCubit>();

    return MultiBlocListener(
      listeners: [
        BlocListener<SignUpCubit, SignUpState>(
          listener: (context, state) {
            if (state is SignUpSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Registration successful! Please login."),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.signInScreen,
                (route) => false,
              );
            } else if (state is SignUpFailure) {
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
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 29.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 33.h),
                  const CustomBackButton(),
                  SizedBox(height: 30.h),
                  Text(
                    AppLocalizations.of(context)!.create_account,
                    style: AppStyles.primary30W800Style,
                  ),
                  SizedBox(height: 7.h),
                  Text(
                    AppLocalizations.of(context)!.sign_up_subtitle,
                    style: AppStyles.subTitleTextStyle.copyWith(
                      fontSize: 18.sp,
                    ),
                  ),
                  SizedBox(height: 25.h),

                  Form(
                    key: cubit.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextFormField(
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12.w,
                                  vertical: 4.h,
                                ),
                                controller: cubit.firstNameController,
                                hintText: AppLocalizations.of(
                                  context,
                                )!.first_name,
                                hintTextStyle:
                                    AppStyles.mediumDarkGray20W400Style,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty)
                                    return "required";
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(width: 43.w),
                            Expanded(
                              child: CustomTextFormField(
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12.w,
                                  vertical: 4.h,
                                ),
                                controller: cubit.lastNameController,
                                hintText: AppLocalizations.of(
                                  context,
                                )!.last_name,
                                hintTextStyle:
                                    AppStyles.mediumDarkGray20W400Style,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty)
                                    return "required";
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 23.h),

                        Text(
                          AppLocalizations.of(context)!.date_of_birth,
                          style: AppStyles.titleTextStyle.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 13.h),
                        CustomTextFormField(
                          contentPadding: EdgeInsets.only(top: 9.h),
                          hintText: "dd/MM/yyyy",
                          controller: cubit.dateController,
                          prefixIcon: Image.asset(AppImages.dateIcon),
                          prefixIconHeight: 19.h,
                          prefixIconWidth: 19.w,
                          width: 324.w,
                          readOnly: true,
                          onTap: () => cubit.pickDate(context),
                          suffixIcon: IconButton(
                            onPressed: () => cubit.pickDate(context),
                            icon: Icon(
                              Icons.calendar_month,
                              size: 25.h,
                              color: AppColors.platinumGray,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty)
                              return "Date of birth required";
                            return null;
                          },
                        ),
                        SizedBox(height: 24.h),

                        Text(
                          AppLocalizations.of(context)!.gender,
                          style: AppStyles.titleTextStyle.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 11.h),
                        BlocBuilder<SignUpCubit, SignUpState>(
                          buildWhen: (_, curr) => curr is SignUpGenderChanged,
                          builder: (context, state) {
                            return SizedBox(
                              width: 324.w,
                              child: DropdownButtonFormField<String>(
                                hint: Text(
                                  AppLocalizations.of(context)!.select_gender,
                                ),
                                value: cubit.selectedGender,
                                validator: (value) =>
                                    value == null ? 'Gender required' : null,
                                // Display "Male"/"Female" and send the same to cubit
                                items: [
                                  DropdownMenuItem(
                                    value: "Male",
                                    child: Text(
                                      AppLocalizations.of(context)!.male,
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    value: "Female",
                                    child: Text(
                                      AppLocalizations.of(context)!.female,
                                    ),
                                  ),
                                ],
                                onChanged: cubit.onGenderChanged,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 12.w,
                                    vertical: 4.h,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.r),
                                    borderSide: BorderSide(
                                      color: AppColors.primaryColor,
                                      width: 1.5,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.r),
                                    borderSide: BorderSide(
                                      color: AppColors.lightGray,
                                      width: 1.5,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.r),
                                    borderSide: BorderSide(
                                      color: AppColors.lostColor,
                                      width: 1.5,
                                    ),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.r),
                                    borderSide: BorderSide(
                                      color: AppColors.lostColor,
                                      width: 1.5,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 24.h),

                        Text(
                          AppLocalizations.of(context)!.phone_number,
                          style: AppStyles.titleTextStyle.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 7.h),
                        CustomTextFormField(
                          width: 324.w,
                          controller: cubit.phoneController,
                          hintText: AppLocalizations.of(
                            context,
                          )!.phone_number_hint,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 4.h,
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Phone number is required";
                            }
                            if (value.trim().length < 11) {
                              return "Enter a valid phone number";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 24.h),

                        Text(
                          AppLocalizations.of(context)!.email,
                          style: AppStyles.titleTextStyle.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 7.h),
                        CustomTextFormField(
                          width: 324.w,
                          controller: cubit.emailController,
                          hintText: AppLocalizations.of(context)!.email_hint,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 4.h,
                          ),
                          prefixIcon: Image.asset(AppImages.emailIcon),
                          prefixIconHeight: 28.h,
                          prefixIconWidth: 37.w,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty)
                              return "Email is required";
                            final emailRegex = RegExp(
                              r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                            );
                            if (!emailRegex.hasMatch(value.trim()))
                              return "Enter a valid email";
                            return null;
                          },
                        ),
                        SizedBox(height: 24.h),

                        Text(
                          AppLocalizations.of(context)!.password,
                          style: AppStyles.titleTextStyle.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 5.h),
                        BlocBuilder<SignUpCubit, SignUpState>(
                          buildWhen: (_, curr) =>
                              curr is SignUpPasswordVisibilityChanged,
                          builder: (context, state) {
                            return CustomTextFormField(
                              width: 324.w,
                              controller: cubit.passwordController,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 12.w,
                                vertical: 4.h,
                              ),
                              isPassword: cubit.isPasswordHidden,
                              hintText: AppLocalizations.of(
                                context,
                              )!.password_hint,
                              hintTextStyle: TextStyle(
                                fontSize: 18.sp,
                                color: AppColors.lightGray,
                              ),
                              prefixIcon: Image.asset(AppImages.passwordIcon),
                              prefixIconWidth: 27.w,
                              prefixIconHeight: 27.h,
                              suffixIcon: IconButton(
                                iconSize: 27.w,
                                onPressed: cubit.togglePasswordVisibility,
                                icon: Icon(
                                  cubit.isPasswordHidden
                                      ? Icons.remove_red_eye_outlined
                                      : Icons.remove_red_eye,
                                  color: AppColors.mediumDarkGray,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty)
                                  return "Password is required";
                                if (value.length < 6)
                                  return "Password must be at least 6 characters";
                                return null;
                              },
                            );
                          },
                        ),
                        SizedBox(height: 34.h),
                      ],
                    ),
                  ),

                  BlocBuilder<SignUpCubit, SignUpState>(
                    buildWhen: (_, curr) =>
                        curr is SignUpLoading ||
                        curr is SignUpFailure ||
                        curr is SignUpInitial ||
                        curr is SignUpSuccess,
                    builder: (context, state) {
                      return AlaaCustomButton(
                        onPressed: state is SignUpLoading ? null : cubit.signUp,
                        width: 328.w,
                        height: 52.h,
                        buttonText: state is SignUpLoading
                            ? "..."
                            : AppLocalizations.of(context)!.sign_up,
                        fontWeight: FontWeight.w800,
                      );
                    },
                  ),
                  SizedBox(height: 24.h),
                  SignOrWidget(),
                  SizedBox(height: 23.h),

                  BlocBuilder<AuthCubit, AuthState>(
                    buildWhen: (_, curr) =>
                        curr is AuthLoading ||
                        curr is AuthFailure ||
                        curr is AuthInitial,
                    builder: (context, state) {
                      return CustomOutlinedButton(
                        onPressed: state is AuthLoading
                            ? null
                            : () =>
                                  context.read<AuthCubit>().signInWithGoogle(),
                        buttonText: state is AuthLoading
                            ? AppLocalizations.of(context)!.connecting
                            : AppLocalizations.of(
                                context,
                              )!.continue_with_google,
                        prefixIcon: AppImages.googleIcon,
                      );
                    },
                  ),

                  SizedBox(height: 32.h),
                  Center(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: AppLocalizations.of(
                          context,
                        )!.already_have_account,
                        style: AppStyles.primary17W400Style.copyWith(
                          color: AppColors.blackColor,
                        ),
                        children: [
                          TextSpan(
                            text: AppLocalizations.of(context)!.sign_in,
                            style: AppStyles.primary17W400Style,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Navigator.pushNamed(
                                context,
                                AppRoutes.signInScreen,
                              ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 25.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
