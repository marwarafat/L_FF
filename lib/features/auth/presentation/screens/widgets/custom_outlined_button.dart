import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/app_colors.dart';

class CustomOutlinedButton extends StatelessWidget {
  final String? buttonText;
  final double? width;
  final double? height;
  final double? radius;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final void Function()? onPressed;
  final Color? borderColor;
  final String? prefixIcon;
  const CustomOutlinedButton({
    super.key,
    this.buttonText,
    this.width,
    this.height,
    this.radius,
    this.textColor,
    this.fontSize,
    this.fontWeight,
    this.onPressed,
    this.borderColor,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: ElevatedButton.styleFrom(
        side: BorderSide(color: borderColor ?? AppColors.lightGray),
        fixedSize: Size(width ?? 324.w, height ?? 52.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(radius ?? 15.r),
        ),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(prefixIcon!),
          SizedBox(width: 10.w),
          Text(
            buttonText ?? " ",
            style: TextStyle(
              fontSize: fontSize ?? 20.sp,
              color: textColor ?? AppColors.blackColor,
              fontWeight: fontWeight ?? FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
