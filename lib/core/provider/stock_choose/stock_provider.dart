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

final stockQuotesInfoProvider = FutureProvider<List<List<double>>>((ref) async {
  final service = StockServiceImpl();
  final stocks = await service.getStockList();
  List<double> costs = [];
  List<double> grows = [];
  for (Stock stock in stocks) {
    final quotes = stock.quotesHistory.values.toList();
    costs.add(quotes[365]);
    grows.add((quotes[365] / quotes[0]) * 100 - 100);
  }
  return [costs, grows];
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
