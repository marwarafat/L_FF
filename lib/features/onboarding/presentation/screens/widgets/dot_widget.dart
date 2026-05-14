import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/app_colors.dart';

class DotWidget extends StatelessWidget {
  final bool isActive;
  const DotWidget({super.key, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 9.w,
      height: 9.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? AppColors.primaryColor : const Color(0xffB3B3B3),
      ),
    );
  }
}
