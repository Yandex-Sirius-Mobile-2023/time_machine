enum ThemeOptions {
  light,
  dark,
  system;

  String toJson() => name;
  static ThemeOptions fromJson(String json) => values.byName(json);
}

/// Interface for settings container manager.
abstract class SettingsContainer {
  void saveTheme(ThemeOptions options);
  ThemeOptions getThemeSettings();
  Stream get settingsUpdates;
}
