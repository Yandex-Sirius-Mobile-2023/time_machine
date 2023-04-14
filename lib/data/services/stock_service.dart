import '../models/stock.dart';

abstract class StockService {
  Future<List<Stock>> getStockList();
  Future<Stock> getStock(StockTicker ticker);
  Future<List<double>> getStockRisk(Map<Stock, int> portfolio);
}
