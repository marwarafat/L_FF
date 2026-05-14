import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constants/app_colors.dart';

class CategoryContainer extends StatelessWidget {
  final String? containerText;
  final Color? containerTextColor;
  final double? containerTextFontSize;
  final FontWeight? containerTextFontWeight;
  final Color? backgroundColor;
  final double? borderRadius;
  final double? width;
  final double? height;
  final void Function()? onTap;

  const CategoryContainer({
    super.key,
    this.containerText,
    this.backgroundColor,
    this.borderRadius,
    this.width,
    this.height,
    this.containerTextColor,
    this.containerTextFontSize,
    this.containerTextFontWeight,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.coolGray,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(borderRadius ?? 10.r),
        ),
        width: width ?? 86.w,
        height: height ?? 39.h,
        child: Center(
          child: Text(
            containerText ?? " ",
            style: TextStyle(
              color: containerTextColor ?? AppColors.blackColor,
              fontSize: containerTextFontSize ?? 20.sp,
              fontWeight: containerTextFontWeight ?? FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
