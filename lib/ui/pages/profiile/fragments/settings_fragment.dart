import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:time_machine/app.dart';
import 'package:time_machine/core/provider/auth_provider.dart';
import 'package:time_machine/data/settings/settings_manager.dart';
import 'package:time_machine/di_providers.dart';
import 'package:time_machine/ui/pages/profiile/commons/options_text_header.dart';
import 'package:time_machine/ui/pages/profiile/profile_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:time_machine/uikit/themes/ui_colors.dart';

class SettingsFragment extends ConsumerWidget {
  /// Pressed right switch button.
  const SettingsFragment({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigator = Navigator.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: containerBottomPadding),
        OptionsTextHeader(AppLocalizations.of(context)!.options),
        const _ThemeDropdownButton(),
        const _LanguageDropdownButton(),
        const SizedBox(height: 16),
        TextButton(
          child: Text(
            AppLocalizations.of(context)!.signOut,
            style: const TextStyle(
              color: UIColors.redAccent,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          onPressed: () async {
            await ref.read(firebaseAuthProvider).signOut();
            navigator.pushReplacementNamed(AppRoutes.loginURL);
          },
        )
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
    var themeNotifier = ref.watch(
      themeProvider.notifier,
    );

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          AppLocalizations.of(context)!.themeOptions,
          style: const TextStyle(
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
                  child: Text(
                    textFromTheme(
                      e,
                      AppLocalizations.of(context)!,
                    ),
                  ),
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

  static String textFromTheme(
      ThemeSettings settings, AppLocalizations localizations) {
    switch (settings) {
      case ThemeSettings.dark:
        return localizations.darkTheme;
      case ThemeSettings.light:
        return localizations.lightTheme;
      case ThemeSettings.system:
        return localizations.systemTheme;
    }
  }
}

class _LanguageDropdownButton extends ConsumerWidget {
  const _LanguageDropdownButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var colorScheme = Theme.of(context).colorScheme;
    var languageNotifier = ref.watch(languageProvider.notifier);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          AppLocalizations.of(context)!.languageOptions,
          style: const TextStyle(
            fontSize: _ThemeDropdownButton.fontSyze,
          ),
        ),
        const SizedBox(width: 16),
        DropdownButton(
          value: ref.watch(languageProvider).languageCode,
          style: TextStyle(
            fontSize: _ThemeDropdownButton.fontSyze,
            color: colorScheme.onBackground,
            fontWeight: FontWeight.w500,
          ),
          items: AppLocalizations.supportedLocales
              .map<DropdownMenuItem<String>>(
                (e) => DropdownMenuItem(
                  value: e.languageCode,
                  child: Text(e.languageCode.toUpperCase()),
                ),
              )
              .toList(),
          onChanged: (val) {
            languageNotifier.saveLanguage(
              Locale(
                val!,
              ),
            );
          },
          dropdownColor: colorScheme.background,
        ),
      ],
    );
  }
}
