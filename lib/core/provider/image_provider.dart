import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:time_machine/data/env.dart';
import 'package:time_machine/data/models/stock.dart';
import 'package:time_machine/data/stocks_api/finhub_api.dart';

final stockImageProvider =
    FutureProvider.family<String, StockTicker>((ref, ticker) async {
  final service = FinhubApi(Env.finhubKey, Dio());
  final stockDto = await service
      .fetchStock(ticker.toString().split('.').last.replaceAll('_', '.'));
  return stockDto.logo;
});
