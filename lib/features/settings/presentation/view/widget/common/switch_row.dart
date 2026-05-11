import 'package:flutter/material.dart';
import '../../../../../../core/styles/app_colors.dart';

class SwitchRow extends StatelessWidget {
  final String title;
  final String? subtitle;
  final bool value;
  final Function(bool)? onChanged;

  const SwitchRow({
    super.key,
    required this.title,
    required this.subtitle,
    required this.value,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w400,
          color: AppColors.black,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: AppColors.textSecondary,
              ),
            )
          : null,

      value: value,

      activeTrackColor: AppColors.success,
      activeThumbColor: AppColors.white,

      inactiveThumbColor: AppColors.white,
      inactiveTrackColor: AppColors.greyMedium,

      onChanged: onChanged, // 👈 المهم هنا
    );
  }
}
