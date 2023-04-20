import 'dart:ui';

enum ThemeSettings {
  light,
  dark,
  system;

  String toJson() => name;
  static ThemeSettings fromJson(String json) => values.byName(json);
}

/// Interface for settings manager.
abstract class SettingsManager {
  void saveTheme(ThemeSettings options);
  ThemeSettings getThemeSettings();
  void saveLanguage(Locale locale);
  Locale getLocale();
}
