import 'package:flutter/material.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../../../core/styles/app_colors.dart';
import '../../../../../core/routing/app_routes.dart';

class AccountSection extends StatelessWidget {
  const AccountSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.greyMedium),
        ),
        child: Column(
          children: [
            /// Account Settings
            InkWell(
              onTap: () => Navigator.pushNamed(context, AppRoutes.settings),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/icons/settings_outline.png',
                      color: AppColors.black,
                      width: 24,
                      height: 24,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        l10n.accountSettings,
                        style: const TextStyle(
                          fontFamily: 'AbhayaLibre',
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black,
                        ),
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios, size: 16),
                  ],
                ),
              ),
            ),
            const Divider(height: 1),

            /// Log Out
            InkWell(
              onTap: () {
                Navigator.pushReplacementNamed(context, AppRoutes.login);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/icons/logout_solid.png',
                      color: AppColors.danger,
                      width: 24,
                      height: 24,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        l10n.logout,
                        style: const TextStyle(
                          fontFamily: 'AbhayaLibre',
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: AppColors.danger,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
