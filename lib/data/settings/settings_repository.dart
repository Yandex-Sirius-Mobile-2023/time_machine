import 'dart:ui';

import 'package:hive/hive.dart';
import 'package:time_machine/data/settings/settings_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension ThemeOptionsJson on ThemeSettings {
  String toJson() => name;
  static ThemeSettings fromJson(String json) =>
      ThemeSettings.values.byName(json);
}

abstract class SettingsRepositoryKeys {
  static const String theme = "theme";
  static const String language = "language";
}

class SettingsRepository implements SettingsManager {
  static const String boxPath = "settings";
  final Box settingsBox;

  SettingsRepository(this.settingsBox);

  @override
  void saveTheme(ThemeSettings options) async {
    settingsBox.put(SettingsRepositoryKeys.theme, options.toJson());
  }

  @override
  ThemeSettings getThemeSettings() {
    var value = settingsBox.get(SettingsRepositoryKeys.theme);
    if (value == null) return ThemeSettings.system;
    return ThemeSettings.fromJson(value);
  }

  @override
  Locale getLocale() {
    var value = settingsBox.get(SettingsRepositoryKeys.language);
    if (value == null) return AppLocalizations.supportedLocales[0];
    return Locale(value.toString());
  }

  @override
  void saveLanguage(Locale locale) {
    settingsBox.put(SettingsRepositoryKeys.language, locale.languageCode);
  }
}
