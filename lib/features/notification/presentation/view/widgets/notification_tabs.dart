import 'package:flutter/material.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../../../core/styles/app_colors.dart';

class NotificationTabs extends StatelessWidget {
  final int selectedTab;
  final Function(int) onTabChanged;

  const NotificationTabs({
    super.key,
    required this.selectedTab,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          tabButton(context, l10n.all, 0),
          const SizedBox(width: 8),
          tabButton(context, l10n.unread, 1),
          const SizedBox(width: 8),
          tabButton(context, l10n.matches, 2),
        ],
      ),
    );
  }

  // Widget tabButton(String text, int index) {
  //   return GestureDetector(
  //     onTap: () => onTabChanged(index),
  //     // {
  //     //   setState(() {
  //     //     selectedTab = index;
  //     //   });
  //     // },
  //     child: Container(
  //       padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),

  //       decoration: BoxDecoration(
  //         color: selectedTab == index ? AppColors.primary : AppColors.border,
  //         borderRadius: BorderRadius.circular(10),
  //       ),
  //       child: Text(
  //         text,
  //         style: TextStyle(
  //           fontFamily: 'AbhayaLibre',

  //           fontSize: 20,
  //           fontWeight: FontWeight.w400,
  //           color: selectedTab == index ? AppColors.white : AppColors.black,
  //         ),
  //       ),
  //     ),
  //   );
  // }
  Widget tabButton(BuildContext context, String text, int index) {
    bool isSelected = selectedTab == index;
    return GestureDetector(
      onTap: () => onTabChanged(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.transparent : Colors.grey[300]!,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontFamily: 'AbhayaLibre',
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.white : Colors.grey[600],
          ),
        ),
      ),
    );
  }
}
