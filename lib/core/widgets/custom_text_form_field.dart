import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';

class CustomTextFormField extends StatelessWidget {
  final double? width;
  final double? height;
  final String? hintText;
  final TextStyle? hintTextStyle;
  final double? borderRadius;
  final Color? borderColor;
  final Color? fillColor;
  final Color? cursorColor;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final double? prefixIconWidth;
  final double? prefixIconHeight;
  final double? suffixIconWidth;
  final double? suffixIconHeight;
  final EdgeInsetsGeometry? prefixPadding;
  final bool? isPassword;
  final bool? readOnly;
  final void Function()? onTap;
  final void Function(String)? onChanged; 
  final EdgeInsetsGeometry? contentPadding;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const CustomTextFormField({
    super.key,
    this.width,
    this.height,
    this.hintText,
    this.hintTextStyle,
    this.borderRadius,
    this.borderColor,
    this.suffixIcon,
    this.prefixIcon,
    this.fillColor,
    this.cursorColor,
    this.prefixIconWidth,
    this.prefixIconHeight,
    this.isPassword,
    this.controller,
    this.validator,
    this.readOnly,
    this.onTap,
    this.onChanged, 
    this.contentPadding,
    this.suffixIconWidth,
    this.suffixIconHeight,
    this.prefixPadding,
  });

  OutlineInputBorder _buildBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius ?? 15.r),
      borderSide: BorderSide(color: color, width: 1.5),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 353.w,
      height: height ?? 80.h,
      child: TextFormField(
        controller: controller,
        validator: validator,
        readOnly: readOnly ?? false,
        obscureText: isPassword ?? false,
        autofocus: false,
        onTap: onTap,
        onChanged: onChanged, 
        cursorColor: cursorColor ?? AppColors.primaryColor,
        decoration: InputDecoration(
          isDense: true,
          helperText: " ",
          helperStyle: const TextStyle(height: 0, fontSize: 1),
          contentPadding: contentPadding ??
              EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
          filled: true,
          fillColor: fillColor ?? AppColors.whiteColor,
          hintText: hintText ?? " ",
          hintStyle: hintTextStyle ??
              AppStyles.platinumGray20W400Style.copyWith(
                color: AppColors.lightGray,
              ),
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon != null
              ? Padding(
                  padding: prefixPadding ?? EdgeInsets.all(8.0.w),
                  child: prefixIcon,
                )
              : null,
          enabledBorder: _buildBorder(borderColor ?? AppColors.lightGray),
          focusedBorder: _buildBorder(AppColors.primaryColor),
          errorBorder: _buildBorder(Colors.red),
          focusedErrorBorder: _buildBorder(Colors.red),
        ),
      ),
    );
  }
}
