import 'dart:async';

import 'package:hive/hive.dart';
import 'package:time_machine/data/theme/settings_container.dart';

extension ThemeOptionsJson on ThemeOptions {
  String toJson() => name;
  static ThemeOptions fromJson(String json) => ThemeOptions.values.byName(json);
}

abstract class SettingsRepositoryKeys {
  static const String theme = "theme";
}

class SettingsRepository implements SettingsContainer {
  final Box settingsBox;

  SettingsRepository(this.settingsBox);

  @override
  void saveTheme(ThemeOptions options) async {
    settingsBox.put(SettingsRepositoryKeys.theme, options.toJson());
  }

  @override
  ThemeOptions getThemeSettings() {
    var value = settingsBox.get(SettingsRepositoryKeys.theme);
    return ThemeOptions.fromJson(value);
  }

  @override
  Stream get settingsUpdates => settingsBox.watch();
}
