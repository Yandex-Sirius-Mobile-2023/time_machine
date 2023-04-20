import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import 'package:time_machine/data/settings/settings_manager.dart';
import 'package:time_machine/di_providers.dart';
import 'package:time_machine/uikit/themes/dark_theme.dart';
import 'package:time_machine/uikit/themes/light_theme.dart';

class ThemeDataNotifier extends StateNotifier<ThemeData> {
  final SettingsManager settingsManager;

  ThemeDataNotifier({
    required this.settingsManager,
    required bool systemDarkMode,
  }) : super(
          isLightTheme(
            settingsManager.getThemeSettings(),
            isSystemLightTheme,
          )
              ? lightTheme
              : darkTheme,
        );

  void setTheme(ThemeSettings settings) {
    settingsManager.saveTheme(settings);
    switch (settings) {
      case ThemeSettings.light:
        state = lightTheme;
        break;
      case ThemeSettings.dark:
        state = darkTheme;
        break;
      case ThemeSettings.system:
        state = isSystemLightTheme ? lightTheme : darkTheme;
        break;
    }
  }

  static bool get isSystemLightTheme =>
      WidgetsBinding.instance.platformDispatcher.platformBrightness ==
      Brightness.light;

  static bool isLightTheme(ThemeSettings settings, bool defaultLight) {
    return (settings == ThemeSettings.system && defaultLight) ||
        settings == ThemeSettings.light;
  }
}

final themeProvider =
    StateNotifierProvider.family<ThemeDataNotifier, ThemeData, bool>(
  (ref, args) => ThemeDataNotifier(
    settingsManager: ref.watch(settingsRepoProvider),
    systemDarkMode: args,
  ),
);
