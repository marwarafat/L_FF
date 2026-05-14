import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../l10n/app_localizations.dart';

import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import '../bloc/profile_state.dart';
import 'widgets/profile_header.dart';
import 'widgets/report_card.dart';
import 'widgets/account_section.dart';
import '../../../auth/data/repo/auth_repo.dart';

import '../../domain/usecases/get_user_profile_usecase.dart';
import '../../domain/usecases/get_user_reports_usecase.dart';
import '../../data/datasources/profile_remote_data_source.dart';
import '../../data/repositories/profile_repository_impl.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/styles/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (context) => sl<ProfileBloc>()..add(LoadProfileEvent()),
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state.loading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          if (state.errorMessage != null) {
            return Scaffold(
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
                  l10n.profileTitle,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: Colors.red,
                        size: 60,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        state.errorMessage!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.red),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton.icon(
                        onPressed: () {
                          // Force logout
                          sl<AuthRepo>().logout();
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            AppRoutes.signInScreen,
                            (route) => false,
                          );
                        },
                        icon: const Icon(Icons.logout),
                        label: const Text("Logout & Login Again"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

          final profile = state.profile!;
          final reports = state.reports;

          return Scaffold(
            backgroundColor: AppColors.white,
            extendBody: false,
            appBar: AppBar(
              backgroundColor: AppColors.white,
              elevation: 0,
              leading: IconButton(
                onPressed: () => Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.mainScreen,
                  (route) => false,
                ),
                icon: const Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: Colors.black,
                  size: 18,
                ),
              ),
              title: Text(
                l10n.profileTitle,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'AbhayaLibre',
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
                    children: [
                      ProfileHeader(profile: profile),
                      const SizedBox(height: 30),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          l10n.myReports,
                          style: const TextStyle(
                            fontFamily: 'AbhayaLibre',
                            fontSize: 25,
                            fontWeight: FontWeight.w800,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      if (reports == null || reports.isEmpty)
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Center(child: Text(l10n.noReportsFound)),
                        )
                      else
                        ...reports.map(
                          (report) => ReportCard(
                            report: report,
                            profileName: profile.fullName,
                          ),
                        ),
                      const SizedBox(height: 20),
                      const AccountSection(),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
