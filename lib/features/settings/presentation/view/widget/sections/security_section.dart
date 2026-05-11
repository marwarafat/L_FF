import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../common/settings_row.dart';
import '../common/settings_section.dart';
import '../../../bloc/settings_bloc.dart';
import '../../../bloc/settings_event.dart';
import '../../../bloc/settings_state.dart';
import '../../../../../../core/storage/token_storage.dart';
import '../../../../../../l10n/app_localizations.dart';
import '../../../../../../core/routing/app_routes.dart';
import '../../../../../../core/styles/app_colors.dart';

class SecuritySection extends StatelessWidget {
  const SecuritySection({super.key});

  void _handleLogout(BuildContext context) {
    final refreshToken = CacheHelper.getData(key: "refreshToken") ?? '';
    context.read<SettingsBloc>().add(LogoutEvent(refreshToken: refreshToken));
    Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.signInScreen, (route) => false);
  }

  void _handleLogoutAllDevices(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.logoutAllDevices),
        content: Text(AppLocalizations.of(context)!.logoutAllConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          TextButton(
            onPressed: () {
              context.read<SettingsBloc>().add(LogoutAllDevicesEvent());
              Navigator.pop(dialogContext);
              Navigator.of(
                context,
              ).pushNamedAndRemoveUntil(AppRoutes.signInScreen, (route) => false);
            },
            child: Text(
              AppLocalizations.of(context)!.logoutAllBtn,
              style: TextStyle(color: AppColors.dangerRed),
            ),
          ),
        ],
      ),
    );
  }

  void _showActiveSessions(BuildContext context) {
    final settingsBloc = context.read<SettingsBloc>();
    settingsBloc.add(GetActiveSessionsEvent());

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (innerContext) {
        return BlocProvider.value(
          value: settingsBloc,
          child: BlocBuilder<SettingsBloc, SettingsState>(
            builder: (context, state) {
              return DraggableScrollableSheet(
                initialChildSize: 0.6,
                minChildSize: 0.4,
                maxChildSize: 0.9,
                expand: false,
                builder: (context, scrollController) {
                  if (state.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state.activeSessions.isEmpty) {
                    return Center(
                      child: Text(
                        AppLocalizations.of(context)!.noActiveSessions,
                      ),
                    );
                  }

                  return Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.activeSessions,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Expanded(
                          child: ListView.separated(
                            controller: scrollController,
                            itemCount: state.activeSessions.length,
                            separatorBuilder: (context, index) =>
                                const Divider(),
                            itemBuilder: (context, index) {
                              final session = state.activeSessions[index];
                              return ListTile(
                                leading: const Icon(
                                  Icons.phone_android_rounded,
                                  color: AppColors.primaryBlue,
                                ),
                                title: Text(
                                  session['deviceName'] ?? 'Unknown Device',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  "${AppLocalizations.of(context)!.lastActive}: ${session['lastActive'] ?? 'N/A'}",
                                ),
                                trailing: session['isCurrent'] == true
                                    ? Chip(
                                        label: Text(
                                          AppLocalizations.of(
                                            context,
                                          )!.currentSession,
                                          style: TextStyle(
                                            color: AppColors.white,
                                            fontSize: 12,
                                          ),
                                        ),
                                        backgroundColor: AppColors.successGreen,
                                      )
                                    : null,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      title: AppLocalizations.of(context)!.security,
      children: [
        SettingsRow(
          icon: Icons.security,
          title: AppLocalizations.of(context)!.changePassword,
          subtitle: AppLocalizations.of(context)!.updatePasswordSubtitle,
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.changePasswordScreen);
          },
        ),
        const Divider(height: 1),
        SettingsRow(
          icon: Icons.phone_iphone_rounded,
          title: AppLocalizations.of(context)!.activeSession,
          subtitle: AppLocalizations.of(context)!.manageActiveDevices,
          onTap: () => _showActiveSessions(context),
        ),
        const Divider(height: 1),
        SettingsRow(
          icon: Icons.devices_other_rounded,
          title: AppLocalizations.of(context)!.logoutAllDevices,
          subtitle: AppLocalizations.of(context)!.secureAccountEverywhere,
          iconColor: Colors.orange,
          onTap: () => _handleLogoutAllDevices(context),
        ),
        const Divider(height: 1),
        SettingsRow(
          icon: Icons.logout_rounded,
          title: AppLocalizations.of(context)!.logout,
          subtitle: AppLocalizations.of(context)!.endCurrentSession,
          iconColor: AppColors.dangerRed,
          onTap: () => _handleLogout(context),
        ),
      ],
    );
  }
}
