import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../l10n/app_localizations.dart';
import '../../../bloc/settings_bloc.dart';
import '../../../bloc/settings_event.dart';
import '../../../bloc/settings_state.dart';
import '../common/settings_section.dart';
import '../common/switch_row.dart';

class NotificationsSection extends StatelessWidget {
  const NotificationsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        return SettingsSection(
          title: l10n.notifications,
          children: [
            SwitchRow(
              title: l10n.matchFound,
              subtitle: l10n.matchFoundSubtitle,
              value: state.matchNotification,
              onChanged: (value) {
                context.read<SettingsBloc>().add(
                  ToggleMatchNotification(value),
                );
              },
            ),
            const Divider(height: 1),
            SwitchRow(
              title: l10n.commentsOnMyReport,
              subtitle: l10n.commentsOnMyReportSubtitle,
              value: state.commentsNotification,
              onChanged: (value) {
                context.read<SettingsBloc>().add(
                  ToggleCommentsNotification(value),
                );
              },
            ),
            const Divider(height: 1),
            SwitchRow(
              title: l10n.generalUpdates,
              subtitle: l10n.generalUpdatesSubtitle,
              value: state.generalNotification,
              onChanged: (value) {
                context.read<SettingsBloc>().add(
                  ToggleGeneralNotification(value),
                );
              },
            ),
            const Divider(height: 1),
            SwitchRow(
              title: l10n.smsNotification,
              subtitle: l10n.smsNotificationSubtitle,
              value: state.smsNotification,
              onChanged: (value) {
                context.read<SettingsBloc>().add(ToggleSmsNotification(value));
              },
            ),
          ],
        );
      },
    );
  }
}
