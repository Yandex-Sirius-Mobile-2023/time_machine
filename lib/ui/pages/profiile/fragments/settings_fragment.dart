import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:time_machine/core/provider/theme_provider.dart';
import 'package:time_machine/data/settings/settings_manager.dart';
import 'package:time_machine/di_providers.dart';
import 'package:time_machine/ui/pages/profiile/commons/options_text_header.dart';
import 'package:time_machine/ui/pages/profiile/profile_page.dart';

class SettingsFragment extends StatelessWidget {
  /// Pressed right switch button.
  const SettingsFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        SizedBox(height: containerBottomPadding),
        OptionsTextHeader("Options"),
        _ThemeDropdownButton(),
      ],
    );
  }
}

var _themeSettingsProvider = StateProvider(
  (ref) => ref.watch(settingsRepoProvider).getThemeSettings(),
);

class _ThemeDropdownButton extends ConsumerWidget {
  static const double fontSyze = 18;
  static const options = [
    ThemeSettings.dark,
    ThemeSettings.light,
    ThemeSettings.system,
  ];

  const _ThemeDropdownButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var colorScheme = Theme.of(context).colorScheme;
    var themeNotifier = ref.watch(themeProvider.notifier);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          "Theme: ",
          style: TextStyle(
            fontSize: _ThemeDropdownButton.fontSyze,
          ),
        ),
        const SizedBox(width: 16),
        DropdownButton(
          value: ref.watch(_themeSettingsProvider),
          style: TextStyle(
            fontSize: _ThemeDropdownButton.fontSyze,
            color: colorScheme.onBackground,
            fontWeight: FontWeight.w500,
          ),
          items: _ThemeDropdownButton.options
              .map<DropdownMenuItem<ThemeSettings>>(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Text(e.name),
                ),
              )
              .toList(),
          onChanged: (val) {
            themeNotifier.setTheme(val!);
            ref.watch(_themeSettingsProvider.notifier).state = val;
          },
          dropdownColor: colorScheme.background,
        ),
      ],
    );
  }
}
