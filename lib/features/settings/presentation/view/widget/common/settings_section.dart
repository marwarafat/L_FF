import 'package:flutter/material.dart';
import '../../../../../../core/constants/app_decoration.dart';

class SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const SettingsSection({
    super.key,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: settingsBoxDecoration,
          child: Column(children: children),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
