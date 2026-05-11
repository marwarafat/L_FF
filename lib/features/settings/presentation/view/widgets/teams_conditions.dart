import 'package:flutter/material.dart';
import 'min_widget/policy_section.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../../../core/styles/app_colors.dart';

class TermsConditions extends StatelessWidget {
  const TermsConditions({super.key});

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
          l10n.termsConditionsTitle,
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
                  const Icon(
                    Icons.person_search_rounded,
                    color: AppColors.greyMedium,
                    size: 30,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    l10n.termsConditionsTitle,
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
                l10n.termsIntro,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: AppColors.black,
                ),
              ),

              const SizedBox(height: 30),

              PolicySection(
                title: l10n.beHonestTitle,
                body: l10n.beHonestBody,
              ),
              const SizedBox(height: 30),

              PolicySection(
                title: l10n.respectPrivacyTitle,
                body: l10n.respectPrivacyBody,
              ),
              const SizedBox(height: 30),

              PolicySection(
                title: l10n.safeMeetupsTitle,
                body: l10n.safeMeetupsBody,
              ),
              const SizedBox(height: 30),

              PolicySection(
                title: l10n.noHarassmentTitle,
                body: l10n.noHarassmentBody,
              ),
            ],
          ),
          ),
        ),
      ),
    );
  }
}
