import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import 'package:time_machine/data/settings/settings_manager.dart';

class LanguageDataNotifier extends StateNotifier<Locale> {
  final SettingsManager settingsManager;

  LanguageDataNotifier({
    required this.settingsManager,
  }) : super(settingsManager.getLocale());

  void saveLanguage(Locale locale) {
    settingsManager.saveLanguage(locale);
    state = locale;
  }
}
