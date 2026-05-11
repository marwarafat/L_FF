import 'package:flutter/material.dart';
import '../../../../../../core/styles/app_colors.dart';

class SettingsRow extends StatelessWidget {
  final IconData? icon;
  final String? assetIcon;
  final String title;
  final String? subtitle;
  final Color? iconColor;
  final VoidCallback? onTap;

  const SettingsRow({
    super.key,
    this.icon,
    this.assetIcon,
    required this.title,
    this.subtitle,
    this.iconColor,
    this.onTap,
  }) : assert(
         icon != null || assetIcon != null,
         'Either icon or assetIcon must be provided',
       );

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: assetIcon != null
          ? Image.asset(
              assetIcon!,
              color: iconColor ?? AppColors.greyMedium,
              width: 35,
              height: 35,
            )
          : Icon(icon, color: iconColor ?? AppColors.greyMedium, size: 35),
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
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: AppColors.greyMedium,
      ),
      onTap: onTap,
    );
  }
}
