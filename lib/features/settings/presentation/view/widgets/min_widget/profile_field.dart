import 'package:flutter/material.dart';
import '../../../../../../core/styles/app_colors.dart';

class ProfileField extends StatelessWidget {
  final String title;
  final String hint;
  final IconData? icon;
  final String? assetIcon;
  final Function(String)? onChanged;
  final bool enabled;
  const ProfileField({
    super.key,
    required this.title,
    required this.hint,
    this.icon,
    this.assetIcon,
    this.onChanged,
    this.enabled = true,
  }) : assert(icon != null || assetIcon != null, 'Either icon or assetIcon must be provided');

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            assetIcon != null
                ? Image.asset(assetIcon!, width: 30, height: 30, color: AppColors.black)
                : Icon(icon, size: 30, color: AppColors.black),
            const SizedBox(width: 6),
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: AppColors.black,
              ),
            ),
          ],
        ),

        const SizedBox(height: 2),

        TextFormField(
          onChanged: onChanged,
          enabled: enabled,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ),

            hintText: hint,
            hintStyle: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
            filled: true,
            fillColor: AppColors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.border),
            ),
          ),
        ),
      ],
    );
  }
}
