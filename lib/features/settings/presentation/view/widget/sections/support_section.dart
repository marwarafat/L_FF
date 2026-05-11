import 'package:flutter/material.dart';
import '../common/settings_row.dart';
import '../common/settings_section.dart';
import '../../../../../../l10n/app_localizations.dart';
import '../../../../../../core/routing/app_routes.dart';

class SupportSection extends StatelessWidget {
  const SupportSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return SettingsSection(
      title: l10n.supportAndLegal,
      children: [
        SettingsRow(
          assetIcon: 'assets/icons/email_outline.png',
          title: l10n.contactUs,
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.contactUs);
          },
        ),
        const Divider(height: 1),
        SettingsRow(
          assetIcon: 'assets/icons/privacy_policy.png',
          title: l10n.privacyPolicy,
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.privacyPolicy);
          },
        ),
        const Divider(height: 1),
        SettingsRow(
          assetIcon: 'assets/icons/privacy_shield_doc.png',
          title: l10n.termsConditions,
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.termsConditions);
          },
        ),
        const Divider(height: 1),
        SettingsRow(
          assetIcon: 'assets/icons/report_abuse_doc.png',
          title: l10n.reportAbuse,
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.reportAbuse);
          },
        ),
      ],
    );
  }
}
