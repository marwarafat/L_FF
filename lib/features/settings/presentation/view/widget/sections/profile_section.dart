import 'package:flutter/material.dart';
import '../common/settings_row.dart';
import '../common/settings_section.dart';
import '../../../../../../l10n/app_localizations.dart';
import '../../../../../../core/routing/app_routes.dart';

class ProfileSection extends StatelessWidget {
  const ProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return SettingsSection(
      title: l10n.account,
      children: [
        SettingsRow(
          assetIcon: 'assets/icons/profile_info.png',
          title: l10n.editProfile,
          subtitle: l10n.editProfileSubtitle,
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.editProfile);
          },
        ),
      ],
    );
  }
}
