import 'package:flutter/material.dart';
import '../../../../../../l10n/app_localizations.dart';

class ReportDropdown extends StatelessWidget {
  final String? value;
  final Function(String?) onChanged;

  const ReportDropdown({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return DropdownButtonFormField<String>(
      initialValue: value,
      hint: Text(l10n.fakeSpamReport),
      items: [
        DropdownMenuItem(value: "fake", child: Text(l10n.fakeSpamReport)),
        DropdownMenuItem(value: "Scam", child: Text(l10n.scamFraud)),
        DropdownMenuItem(
          value: "content",
          child: Text(l10n.inappropriateContent),
        ),
        DropdownMenuItem(value: "other", child: Text(l10n.others)),
      ],
      onChanged: onChanged,
    );
  }
}
