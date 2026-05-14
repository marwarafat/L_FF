import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constants/app_colors.dart';

class AlaaCustomButton extends StatelessWidget {
  final String? buttonText;
  final Color? backgrounColor;
  final Color? textColor;
  final double? width;
  final double? height;
  final double? borderRadius;
  final double? fontSize;
  final FontWeight? fontWeight;
  final void Function()? onPressed;

  const AlaaCustomButton({
    super.key,
    this.buttonText,
    this.backgrounColor,
    this.textColor,
    this.width,
    this.height,
    this.borderRadius,
    this.onPressed,
    this.fontSize,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgrounColor ?? AppColors.primaryColor,
        minimumSize: Size(width ?? 278.w, height ?? 48.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(borderRadius ?? 15.r),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        maxLines: 1,
        buttonText ?? " ",
        style: TextStyle(
          color: textColor ?? AppColors.whiteColor,
          fontSize: fontSize ?? 20.sp,
          fontWeight: fontWeight ?? FontWeight.w400,
        ),
      ),
    );
  }
}
