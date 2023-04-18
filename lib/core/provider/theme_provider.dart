import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import 'package:time_machine/uikit/themes/dark_theme.dart';
import 'package:time_machine/uikit/themes/light_theme.dart';

class ThemeDataNotifier extends StateNotifier<ThemeData> {
  ThemeDataNotifier(ThemeMode themeMode)
      : super(
          themeMode == ThemeMode.system ? darkTheme : lightTheme,
        );

  void toogleTheme() {
    state = state == lightTheme ? darkTheme : lightTheme;
  }
}

final themeProvider = StateNotifierProvider<ThemeDataNotifier, ThemeData>(
  (ref) => ThemeDataNotifier(ThemeMode.system),
);
