import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../l10n/app_localizations.dart';

import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import '../bloc/profile_state.dart';
import 'widgets/profile_header.dart';
import 'widgets/report_card.dart';
import 'widgets/account_section.dart';

import '../../domain/usecases/get_user_profile_usecase.dart';
import '../../domain/usecases/get_user_reports_usecase.dart';
import '../../data/datasources/profile_remote_data_source.dart';
import '../../data/repositories/profile_repository_impl.dart';
import '../../../../core/styles/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (_) {
        final dataSource = ProfileRemoteDataSourceImpl();
        final repository = ProfileRepositoryImpl(dataSource);
        return ProfileBloc(
          getUserProfileUseCase: GetUserProfileUseCase(repository),
          getUserReportsUseCase: GetUserReportsUseCase(repository),
        )..add(LoadProfileEvent());
      },
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
              body: Center(child: Text(state.errorMessage!)),
            );
          }

          final profile = state.profile!;
          final reports = state.reports;

          return Scaffold(
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
