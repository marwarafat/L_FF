import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../l10n/app_localizations.dart';
import '../../../bloc/settings_bloc.dart';
import '../../../bloc/settings_event.dart';
import '../../../bloc/settings_state.dart';
import '../common/settings_section.dart';
import '../common/switch_row.dart';

class PrivacySection extends StatelessWidget {
  const PrivacySection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        return SettingsSection(
          title: l10n.privacy,
          children: [
            SwitchRow(
              title: l10n.hidePhoneNumber,
              subtitle: l10n.hidePhoneNumberSubtitle,
              value: state.hidePhone,
              onChanged: (value) {
                context.read<SettingsBloc>().add(ToggleHidePhone(value));
              },
            ),
            const Divider(height: 1),
            SwitchRow(
              title: l10n.hideExactLocation,
              subtitle: l10n.hideExactLocationSubtitle,
              value: state.hideLocation,
              onChanged: (value) {
                context.read<SettingsBloc>().add(ToggleHideLocation(value));
              },
            ),
            const Divider(height: 1),
            SwitchRow(
              title: l10n.postAnonymously,
              subtitle: l10n.postAnonymouslySubtitle,
              value: state.postAnonymously,
              onChanged: (value) {
                context.read<SettingsBloc>().add(TogglePostAnonymously(value));
              },
            ),
          ],
        );
      },
    );
  }
}
