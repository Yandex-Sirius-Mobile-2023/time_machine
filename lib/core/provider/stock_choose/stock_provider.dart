import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:time_machine/core/provider/stock_choose/stock_chooser.dart';
import 'package:time_machine/data/env.dart';
import 'package:time_machine/data/models/stock.dart';
import 'package:time_machine/data/services/stock_service_impl.dart';
import 'package:time_machine/data/stocks_api/finhub_api.dart';

final stockChooseProvider =
    StateNotifierProvider<StockChooser, Map<StockTicker, bool>>(
        (ref) => StockChooser(StockTicker.values));

final stockCostProvider = FutureProvider<Map<StockTicker, double>>((ref) async {
  final service = StockServiceImpl();
  final stocks = await service.getStockList();
  Map<StockTicker, double> stockCosts = {};
  for (Stock stock in stocks) {
    stockCosts[stock.ticker] = stock.quotesHistory.values.toList()[0];
  }
  return stockCosts;
});

final stockImageProvider =
    FutureProvider<Map<StockTicker, String>>((ref) async {
  final service = FinhubApi(Env.finhubKey, Dio());
  Map<StockTicker, String> stockImages = {};
  for (StockTicker ticker in StockTicker.values) {
    final stockDto = await service
        .fetchStock(ticker.toString().split('.').last.replaceAll('_', '.'));
    stockImages[ticker] = stockDto.logo;
  }
  return stockImages;
});
