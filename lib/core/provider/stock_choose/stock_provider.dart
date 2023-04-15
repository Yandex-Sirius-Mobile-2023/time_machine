import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:time_machine/core/provider/stock_choose/stock_chooser.dart';
import 'package:time_machine/data/models/stock.dart';
import 'package:time_machine/data/services/stock_service_impl.dart';

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
