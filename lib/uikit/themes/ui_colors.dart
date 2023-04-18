import 'package:flutter/material.dart';

abstract class UIColors {
  static const black = Color.fromRGBO(22, 22, 22, 1);
  static const deepBlack = Color.fromRGBO(17, 17, 17, 1);
  static const cyanDark = Color.fromRGBO(0, 130, 140, 1);
  static const cyanBright = Color.fromRGBO(5, 192, 182, 1);
  static const cyanLight = Color.fromRGBO(5, 170, 185, 1);
  static const redAccent = Color.fromARGB(255, 241, 89, 80);
  static const redAccentDark = Color.fromARGB(255, 220, 70, 70);
  static const grey = Colors.grey;
  static const darkGrey = Color.fromARGB(255, 118, 118, 118);
  static const blackSurface = Color.fromARGB(255, 28, 28, 28);
  static const whiteSurface = Color.fromRGBO(252, 252, 252, 1);
  static const whiteBackground = Color.fromRGBO(255, 255, 255, 1);
  static const whiteSecondary = Color.fromARGB(255, 241, 243, 245);
  static const whiteSecondaryContainer = Color.fromARGB(255, 232, 234, 236);

  /// Stock grow color.
  static const growColor = Color.fromARGB(255, 15, 202, 112);

  /// Stock drop color.
  static const dropColor = Color.fromRGBO(240, 90, 80, 1);
}
