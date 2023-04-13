import '../models/stock.dart';

abstract class StockService {
  Future<List<Stock>> getStockList();
  Future<Stock> getStock(StockTicker ticker);
  Future<double> getPortfolioRisk(Map<Stock, int> portfolio);
  Future<double> getStockRisk(Stock stock);
}
