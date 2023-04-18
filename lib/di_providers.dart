import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:time_machine/data/env.dart';
import 'package:time_machine/data/stocks_api/finhub_api.dart';
import 'package:time_machine/data/stocks_api/stock_api_repository.dart';
import 'package:time_machine/data/stocks_api/stock_info_provider.dart';
import 'package:time_machine/data/theme/settings_container.dart';
import 'package:time_machine/data/theme/settings_repository.dart';

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

final settingsRepoProvider = Provider<SettingsContainer>(
  (ref) => SettingsRepository(
    Hive.box("setings"),
  ),
);
