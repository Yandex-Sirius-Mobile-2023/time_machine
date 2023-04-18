import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import 'package:time_machine/uikit/themes/dark_theme.dart';
import 'package:time_machine/uikit/themes/light_theme.dart';

class ThemeDataNotifier extends StateNotifier<ThemeData> {
  ThemeDataNotifier(bool isDarkMode)
      : super(
          isDarkMode ? darkTheme : lightTheme,
        );

  void toogleTheme() {
    state = state == lightTheme ? darkTheme : lightTheme;
  }
}

final themeProvider = StateNotifierProvider<ThemeDataNotifier, ThemeData>(
  (ref) => ThemeDataNotifier(
    WidgetsBinding.instance.platformDispatcher.platformBrightness ==
        Brightness.dark,
  ),
);
