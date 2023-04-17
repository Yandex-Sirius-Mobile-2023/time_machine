import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:time_machine/data/env.dart';
import 'package:time_machine/data/stocks_api/finhub_api.dart';
import 'package:time_machine/data/stocks_api/stock_api_repository.dart';
import 'package:time_machine/data/stocks_api/stock_info_provider.dart';

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
