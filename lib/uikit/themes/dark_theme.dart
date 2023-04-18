import 'package:flutter/material.dart';

import 'ui_colors.dart';

final ThemeData darkTheme = ThemeData.dark(
  useMaterial3: true,
).copyWith(
  scaffoldBackgroundColor: UIColors.deepBlack,
  cardColor: UIColors.blackSurface,
  colorScheme: const ColorScheme.dark().copyWith(
    primary: UIColors.cyanBright,
    primaryContainer: UIColors.cyanLight,
    onPrimary: UIColors.whiteSurface,
    secondary: UIColors.whiteSurface,
    secondaryContainer: UIColors.whiteSurface,
    onSecondary: UIColors.whiteSurface,
    surface: UIColors.blackSurface,
    onSurface: UIColors.whiteSurface,
    background: UIColors.deepBlack,
    onBackground: UIColors.whiteBackground,
  ),
);
