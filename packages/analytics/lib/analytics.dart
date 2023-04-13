library analytics;

import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';

class Analytics {
  final String fileName;

  Analytics(this.fileName);

  Future<List<List<dynamic>>> loadCsvData() async {
    final csvFile = File(fileName).openRead();
    return await csvFile
        .transform(utf8.decoder)
        .transform(const CsvToListConverter())
        .toList();
  }

  Future<List<Map<String, dynamic>>> getStockList() async {
    final csvDataList = await loadCsvData();
    final tickerList = csvDataList[0].sublist(2);
    final quoteList = csvDataList.sublist(1);
    List<Map<String, dynamic>> stockList = [];
    for (String ticker in tickerList) {
      Map<String, dynamic> stock = {};
      stock['ticker'] = ticker.substring(4);
      Map<String, double> quotesHistory = {};
      for (List<dynamic> quote in quoteList) {
        final date = quote[1].toString();
        final dateParsed =
            '${date.substring(0, 4)}-${date.substring(4, 6)}-${date.substring(6, 8)}';
        quotesHistory[dateParsed] = quote[tickerList.indexOf(ticker) + 2];
      }
      stock['quotesHistory'] = quotesHistory;
      stockList.add(stock);
    }
    return stockList;
  }
}
