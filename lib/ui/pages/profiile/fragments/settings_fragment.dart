import 'package:flutter/material.dart';
import 'package:time_machine/data/settings/settings_manager.dart';
import 'package:time_machine/ui/pages/profiile/commons/options_text_header.dart';
import 'package:time_machine/ui/pages/profiile/profile_page.dart';

class SettingsFragment extends StatelessWidget {
  /// Pressed right switch button.
  const SettingsFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const [
        SizedBox(height: containerBottomPadding),
        OptionsTextHeader("Options"),
        _ThemeDropdownButton(),
      ],
    );
  }
}

class _ThemeDropdownButton extends StatelessWidget {
  static const double fontSyze = 18;
  static const options = [
    ThemeSettings.dark,
    ThemeSettings.light,
    ThemeSettings.system,
  ];

  const _ThemeDropdownButton();

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        const Text(
          "Theme settings",
          style: TextStyle(
            fontSize: fontSyze,
          ),
        ),
        const SizedBox(width: 16),
        DropdownButton(
          value: ThemeSettings.dark,
          style: const TextStyle(fontSize: fontSyze),
          items: options
              .map<DropdownMenuItem<ThemeSettings>>(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Text(e.name),
                ),
              )
              .toList(),
          onChanged: (_) {},
          dropdownColor: colorScheme.background,
        ),
      ],
    );
  }
}
