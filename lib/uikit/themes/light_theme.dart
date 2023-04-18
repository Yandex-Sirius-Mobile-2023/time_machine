import 'package:flutter/material.dart';

import 'ui_colors.dart';

final ThemeData lightTheme = ThemeData.light(
  useMaterial3: true,
).copyWith(
  primaryColor: UIColors.cyanBright,
  scaffoldBackgroundColor: UIColors.whiteBackground,
  cardColor: UIColors.whiteSurface,
  colorScheme: const ColorScheme.light().copyWith(
    primary: UIColors.cyanBright,
    primaryContainer: UIColors.cyanDark,
    onPrimary: UIColors.black,
    secondary: UIColors.whiteSecondary,
    secondaryContainer: UIColors.whiteSecondaryContainer,
    onSecondary: UIColors.black,
    surface: UIColors.whiteSurface,
    onSurface: UIColors.black,
    background: UIColors.whiteSurface,
    onBackground: UIColors.black,
  ),
);
