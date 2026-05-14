import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_images.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.h),
      height: 70.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
        border: Border.all(color: AppColors.coolGray.withOpacity(0.5), width: 1),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildNavItem(
              icon: AppImages.homeNavigationBar,
              selectedIcon: AppImages.selectedHomeNavigationBar,
              index: 0,
              label: "Home",
            ),
            buildNavItem(
              icon: AppImages.mapNavigationBar,
              selectedIcon: AppImages.selectedMapNavigationBar,
              index: 1,
              label: "Map",
            ),
            _buildCentralButton(),
            buildNavItem(
              icon: AppImages.profileNavigationBar,
              selectedIcon: AppImages.selectedProfileNavigationBar,
              index: 3,
              label: "Profile",
            ),
            buildNavItem(
              icon: AppImages.chatNavigationBar,
              selectedIcon: AppImages.selectedChatNavigationBar,
              index: 4,
              label: "Chat",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCentralButton() {
    bool isSelected = currentIndex == 2;
    return GestureDetector(
      onTap: () => onTap.call(2),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 55.h,
        width: 55.w,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryColor : AppColors.primaryColor.withOpacity(0.9),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryColor.withOpacity(0.4),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Image.asset(
            currentIndex == 2 ? AppImages.selectedAddNavigationBar : AppImages.addNavigationBar,
            height: 30.h,
            width: 30.w,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  final int currentIndex;
  final Function(int) onTap;

  Widget buildNavItem({
    required int index,
    required String icon,
    required String selectedIcon,
    required String label,
  }) {
    bool isSelected = index == currentIndex;
    return GestureDetector(
      onTap: () => onTap.call(index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryColor.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              isSelected ? selectedIcon : icon,
              height: 24.h,
              width: 24.w,
              color: isSelected ? AppColors.primaryColor : AppColors.platinumGray,
            ),
            if (isSelected) ...[
              SizedBox(height: 4.h),
              AnimatedOpacity(
                opacity: isSelected ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 300),
                child: Text(
                  label,
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
