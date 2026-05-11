import 'package:flutter/material.dart';
import '../../../domain/entities/profile_entity.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../../../core/styles/app_colors.dart';

class ProfileHeader extends StatelessWidget {
  final ProfileEntity profile;

  const ProfileHeader({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.textSecondary),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.grey[200],
                  backgroundImage:
                      profile.image != null && profile.image!.startsWith('http')
                      ? NetworkImage(profile.image!) as ImageProvider
                      : null,
                  child:
                      profile.image == null ||
                          !profile.image!.startsWith('http')
                      ? Image.asset(
                          'assets/icons/profile_fill.png',
                          color: AppColors.greyMedium,
                          width: 40,
                          height: 40,
                        )
                      : null,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        profile.fullName,
                        style: const TextStyle(
                          fontFamily: 'AbhayaLibre',
                          fontSize: 25,
                          fontWeight: FontWeight.w800,
                          color: AppColors.primary,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "${l10n.memberSince} ${profile.memberSince ?? '2026'}",
                        style: const TextStyle(
                          fontFamily: 'AbhayaLibre',
                          fontSize: 18,
                          color: AppColors.textTertiary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Image.asset(
                  'assets/icons/email_outline.png',
                  width: 20,
                  height: 20,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    profile.email,
                    style: const TextStyle(
                      fontFamily: 'AbhayaLibre',
                      fontSize: 18,
                      color: AppColors.textSecondary,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Image.asset(
                  'assets/icons/location_outline.png',
                  width: 20,
                  height: 20,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    profile.location ?? l10n.notSpecified,
                    style: const TextStyle(
                      fontFamily: 'AbhayaLibre',
                      fontSize: 18,
                      color: AppColors.textSecondary,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
