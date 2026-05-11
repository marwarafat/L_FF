import 'package:flutter/material.dart';
import 'min_widget/policy_section.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../../../core/styles/app_colors.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.white,

      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          l10n.privacyPolicyTitle,
          style: const TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.w800,
            fontSize: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.description, color: AppColors.greyMedium, size: 30),
                    const SizedBox(width: 8),
                    Text(
                      l10n.privacyPolicyTitle,
                      style: const TextStyle(
                        color: AppColors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                Text(
                  "${l10n.lastUpdated}: March 2026",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: AppColors.black,
                  ),
                ),

                const SizedBox(height: 20),

                Text(
                  l10n.privacyIntro,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: AppColors.black,
                  ),
                ),

                const SizedBox(height: 30),

                PolicySection(
                  title: l10n.infoCollectTitle,
                  body: l10n.infoCollectBody,
                ),

                const SizedBox(height: 30),

                PolicySection(
                  title: l10n.howUseDataTitle,
                  body: l10n.howUseDataBody,
                ),
                const SizedBox(height: 30),

                PolicySection(
                  title: l10n.locationDataTitle,
                  body: l10n.locationDataBody,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
