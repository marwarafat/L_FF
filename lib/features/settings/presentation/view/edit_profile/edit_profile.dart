import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../l10n/app_localizations.dart';
import 'bloc/edit_profile_bloc.dart';
import 'bloc/edit_profile_event.dart';
import 'bloc/edit_profile_state.dart';
import '../widgets/min_widget/profile_field.dart';

import '../../../../profile/domain/usecases/get_user_profile_usecase.dart';
import '../../../domain/usecases/update_profile_usecase.dart';
import '../../../../profile/data/datasources/profile_remote_data_source.dart';
import '../../../../profile/data/repositories/profile_repository_impl.dart';
import '../../../data/datasources/settings_remote_data_source.dart';
import '../../../data/repositories/settings_repository_impl.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/styles/app_colors.dart';

class ProfileInformationScreen extends StatelessWidget {
  const ProfileInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (context) {
        final profileDataSource = ProfileRemoteDataSourceImpl();
        final profileRepository = ProfileRepositoryImpl(profileDataSource);
        
        final settingsDataSource = SettingsRemoteDataSourceImpl();
        final settingsRepository = SettingsRepositoryImpl(settingsDataSource);

        return EditProfileBloc(
          getUserProfileUseCase: GetUserProfileUseCase(profileRepository),
          updateProfileUseCase: UpdateProfileUseCase(settingsRepository),
        )..add(LoadProfile());
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            l10n.editProfile,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w800,
              fontSize: 20,
            ),
          ),
        ),
        body: BlocConsumer<EditProfileBloc, EditProfileState>(
          listener: (context, state) {
            if (state.errorMessage != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage!),
                  backgroundColor: Colors.red,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
            if (state.isSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(l10n.profileUpdatedSuccess),
                  backgroundColor: Colors.green,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          },
          builder: (context, state) {
            final profile = state.profile;

            if (profile == null && state.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildHeader(context),
                      const SizedBox(height: 15),
                      _buildAvatarSection(context),
                      const SizedBox(height: 10),
                      ProfileField(
                        title: l10n.fullName,
                        hint: profile?.name ?? "",
                        assetIcon: 'assets/icons/profile_fill.png',
                        onChanged: (val) =>
                            context.read<EditProfileBloc>().add(UpdateName(val)),
                      ),
                      const SizedBox(height: 6),
                      ProfileField(
                        title: l10n.phoneNumber,
                        hint: profile?.phone ?? "",
                        assetIcon: 'assets/icons/device_mobile.png',
                        onChanged: (val) =>
                            context.read<EditProfileBloc>().add(UpdatePhone(val)),
                      ),
                      const SizedBox(height: 6),
                      ProfileField(
                        title: l10n.emailAddress,
                        hint: profile?.email ?? "",
                        assetIcon: 'assets/icons/email_solid.png',
                        enabled: false, // Email is read-only
                      ),
                      const SizedBox(height: 6),
                      ProfileField(
                        title: l10n.cityGovernorate,
                        hint: profile?.location ?? "",
                        assetIcon: 'assets/icons/location_fill.png',
                        onChanged: (val) =>
                            context.read<EditProfileBloc>().add(UpdateCity(val)),
                      ),
                      const SizedBox(height: 30),
                      _buildSaveButton(context, state),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSaveButton(BuildContext context, EditProfileState state) {
    final l10n = AppLocalizations.of(context)!;
    return CustomButton(
      text: l10n.saveChanges,
      onPressed: () => context.read<EditProfileBloc>().add(SaveProfile()),
      isLoading: state.loading,
    );
  }

  Widget _buildHeader(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Row(
      children: [
        Image.asset('assets/icons/profile_fill.png', color: AppColors.greyMedium, width: 50, height: 50),
        const SizedBox(width: 10),
        Text(
          l10n.profileInformation,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
        ),
      ],
    );
  }

  Widget _buildAvatarSection(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Row(
      children: [
        const CircleAvatar(
          radius: 28,
          backgroundColor: AppColors.primaryButton,
          child: Text(
            "ME",
            style: TextStyle(color: AppColors.white, fontSize: 20),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          l10n.profilePicture,
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
