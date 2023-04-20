import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:time_machine/core/provider/settings/language_data_notifier.dart';
import 'package:time_machine/data/env.dart';
import 'package:time_machine/data/stocks_api/finhub_api.dart';
import 'package:time_machine/data/stocks_api/stock_api_repository.dart';
import 'package:time_machine/data/stocks_api/stock_info_provider.dart';
import 'package:time_machine/data/settings/settings_repository.dart';
import 'package:time_machine/data/settings/settings_manager.dart';

import 'core/provider/settings/theme_data_nortifier.dart';

final dioProvider = Provider<Dio>(
  (ref) => Dio(),
);

final _finhubApiProvider = Provider<FinhubApi>(
  (ref) => FinhubApi(
    Env.finhubKey,
    ref.watch(dioProvider),
  ),
);

final stockInfoServiceProvider = Provider<StockInfoProvider>(
  (ref) => StockApiRepository(
    ref.watch(_finhubApiProvider),
  ),
);

final settingsRepoProvider = Provider<SettingsManager>(
  (ref) => SettingsRepository(
    Hive.box(SettingsRepository.boxPath),
  ),
);

final themeProvider = StateNotifierProvider<ThemeDataNotifier, ThemeData>(
  (ref) => ThemeDataNotifier(
    settingsManager: ref.watch(settingsRepoProvider),
    systemDarkMode: ThemeDataNotifier.isSystemLightTheme,
  ),
);

final languageProvider = StateNotifierProvider<LanguageDataNotifier, Locale>(
  (ref) => LanguageDataNotifier(
    settingsManager: ref.watch(settingsRepoProvider),
  ),
);
