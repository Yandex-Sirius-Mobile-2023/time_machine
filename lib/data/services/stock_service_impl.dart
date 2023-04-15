import 'package:csv/csv.dart';
import 'package:analytics/analytics.dart';
import 'package:flutter/services.dart';
import 'package:time_machine/data/models/stock.dart';
import 'package:time_machine/data/services/stock_service.dart';

class StockServiceImpl extends StockService {
  @override
  Future<List<double>> getStockRisk(Map<Stock, int> portfolio) async {
    final csvDataList = await _loadCsvData();
    final analytics = Analytics(csvDataList);
    final stockList = portfolio.keys.toList();
    List<Map<String, dynamic>> rawStockList = [];
    for (Stock stock in stockList) {
      final rawStock = stock.toJson();
      rawStockList.add(rawStock);
    }
    final risk = analytics.getRisk(rawStockList);
    return risk;
  }

  @override
  Future<Stock> getStock(StockTicker ticker) async {
    final csvDataList = await _loadCsvData();
    final analytics = Analytics(csvDataList);
    final rawStock =
        await analytics.getStock(ticker.toString().split('.').last);
    final stock = Stock.fromJson(rawStock);
    return stock;
  }

  @override
  Future<List<Stock>> getStockList() async {
    final csvDataList = await _loadCsvData();
    final analytics = Analytics(csvDataList);
    final rawStockList = await analytics.getStockList();
    List<Stock> stockList = [];
    for (Map<String, dynamic> rawStock in rawStockList) {
      final stock = Stock.fromJson(rawStock);
      stockList.add(stock);
    }
    return stockList;
  }
}

extension StockServiceExtension on StockServiceImpl {
  Future<List<List<dynamic>>> _loadCsvData() async {
    final csvString =
        await rootBundle.loadString('assets/data/close_data_2010-2023.csv');
    return const CsvToListConverter().convert(csvString);
  }
}
