import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../l10n/app_localizations.dart';
import '../../../bloc/settings_bloc.dart';
import '../../../bloc/settings_event.dart';
import '../../../bloc/settings_state.dart';
import '../../../../../../core/widgets/custom_button.dart';
import '../../../../../../core/styles/app_colors.dart';
import '../../../../../../core/routing/app_routes.dart';

class DangerZoneSection extends StatelessWidget {
  const DangerZoneSection({super.key});

  void _showDeleteConfirmDialog(BuildContext context) {
    final passwordController = TextEditingController();
    final l10n = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder: (dialogContext) => BlocConsumer<SettingsBloc, SettingsState>(
        listener: (context, state) {
          if (state.isSuccess) {
            Navigator.pop(dialogContext);
            Navigator.of(
              context,
            ).pushNamedAndRemoveUntil(AppRoutes.login, (route) => false);
          } else if (state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("${l10n.failed}: ${state.errorMessage}"),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (ctx, state) => AlertDialog(
          title: Text(
            l10n.deleteAccountTitle,
            style: const TextStyle(
              color: AppColors.dangerLight,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                l10n.deleteAccountConfirmMessage,
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: l10n.password,
                  border: const OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text(l10n.cancel),
            ),
            CustomButton(
              text: l10n.delete,
              onPressed: () {
                if (passwordController.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(l10n.pleaseEnterPassword),
                    ),
                  );
                  return;
                }
                context.read<SettingsBloc>().add(
                  DeleteAccountEvent(
                    password: passwordController.text.trim(),
                  ),
                );
              },
              isLoading: state.isLoading,
              backgroundColor: AppColors.dangerLight,
              width: null, // Let it size to the dialog
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFFFE3E3),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset('assets/icons/alert_danger.png', width: 24, height: 24, color: AppColors.dangerLight),
                const SizedBox(width: 8),
                Text(
                  l10n.dangerZone,
                  style: const TextStyle(
                    color: AppColors.dangerLight,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            Text(
              l10n.permanentlyDeleteWarning,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: AppColors.textSecondary,
              ),
            ),

            const SizedBox(height: 10),

            CustomButton(
              text: l10n.deleteAccount,
              onPressed: () => _showDeleteConfirmDialog(context),
              backgroundColor: AppColors.dangerLight,
            ),
          ],
        ),
      ),
    );
  }
}
