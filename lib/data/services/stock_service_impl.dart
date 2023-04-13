import 'package:analytics/analytics.dart';
import 'package:time_machine/data/models/stock.dart';
import 'package:time_machine/data/services/stock_service.dart';

class StockServiceImpl extends StockService {
  @override
  Future<double> getPortfolioRisk(Map<Stock, int> portfolio) {
    // TODO: implement getPortfolioRisk
    throw UnimplementedError();
  }

  @override
  Future<Stock> getStock(StockTicker ticker) {
    // TODO: implement getStock
    throw UnimplementedError();
  }

  @override
  Future<List<Stock>> getStockList() async {
    final analytics = Analytics(
        '/Users/igo320341/Desktop/time_machine/assets/data/close_data_2010-2023.csv');
    final rawStockList = await analytics.getStockList();
    List<Stock> stockList = [];
    for (Map<String, dynamic> rawStock in rawStockList) {
      final stock = Stock.fromJson(rawStock);
      stockList.add(stock);
    }
    return stockList;
  }

  @override
  Future<double> getStockRisk(Stock stock) {
    // TODO: implement getStockRisk
    throw UnimplementedError();
  }
}
