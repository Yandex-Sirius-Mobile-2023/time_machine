import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import 'package:time_machine/uikit/themes/dark_theme.dart';
import 'package:time_machine/uikit/themes/light_theme.dart';

final themeProvider = StateProvider<ThemeData>(
  (ref) => ThemeMode.system == ThemeMode.dark ? darkTheme : lightTheme,
);
