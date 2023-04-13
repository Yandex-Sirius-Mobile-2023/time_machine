import 'package:flutter/material.dart';

const seedColor = Colors.cyan;

final lightScheme = ColorScheme.fromSeed(
  brightness: Brightness.light,
  seedColor: seedColor,
);

final dartTheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: seedColor,
);
