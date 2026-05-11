import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../l10n/app_localizations.dart';
import '../bloc/settings_bloc.dart';
import 'widget/common/danger_zone_section.dart';
import 'widget/sections/notifications_section.dart';
import 'widget/sections/privacy_section.dart';
import 'widget/sections/profile_section.dart';
import 'widget/sections/security_section.dart';
import 'widget/sections/support_section.dart';
import '../../domain/usecases/update_profile_usecase.dart';
import '../../domain/usecases/change_password_usecase.dart';
import '../../domain/usecases/delete_account_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../data/datasources/settings_remote_data_source.dart';
import '../../data/repositories/settings_repository_impl.dart';
import 'widget/sections/language_section.dart';
import '../../../../core/styles/app_colors.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final dataSource = SettingsRemoteDataSourceImpl();
        final repository = SettingsRepositoryImpl(dataSource);
        return SettingsBloc(
          updateProfileUseCase: UpdateProfileUseCase(repository),
          changePasswordUseCase: ChangePasswordUseCase(repository),
          deleteAccountUseCase: DeleteAccountUseCase(repository),
          logoutUseCase: LogoutUseCase(repository),
        );
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Colors.black,
              size: 18,
            ),
          ),
          title: Text(
            AppLocalizations.of(context)!.accountSettings,
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 20,
              color: AppColors.black,
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: const [
              ProfileSection(),
              SecuritySection(),
              NotificationsSection(),
              PrivacySection(),
              DangerZoneSection(),
              LanguageSection(),
              SupportSection(),
              SizedBox(height: 20),
              Text(
                "Wasset Kheir v1.0.0",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textSecondary,
                  fontFamily: 'AbhayaLibre',
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
