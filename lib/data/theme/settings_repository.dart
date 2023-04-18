import 'package:hive/hive.dart';
import 'package:time_machine/data/theme/settings_save_service.dart';

extension ThemeOptionsJson on ThemeSettings {
  String toJson() => name;
  static ThemeSettings fromJson(String json) =>
      ThemeSettings.values.byName(json);
}

abstract class SettingsRepositoryKeys {
  static const String theme = "theme";
}

class SettingsRepository implements SettingsManager {
  final Box settingsBox;

  SettingsRepository(this.settingsBox);

  @override
  void saveTheme(ThemeSettings options) async {
    settingsBox.put(SettingsRepositoryKeys.theme, options.toJson());
  }

  @override
  ThemeSettings getThemeSettings() {
    var value = settingsBox.get(SettingsRepositoryKeys.theme);
    return ThemeSettings.fromJson(value);
  }
}
