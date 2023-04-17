import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:time_machine/core/provider/quotes_info/quotes_info.dart';
import 'package:time_machine/data/models/stock.dart';
import 'package:time_machine/data/services/stock_service_impl.dart';

final stockQuotesInfoProvider = FutureProvider<QuotesInfo>((ref) async {
  final service = StockServiceImpl();
  final stocks = await service.getStockList();
  List<double> costs = [];
  List<double> grows = [];
  for (Stock stock in stocks) {
    final quotes = stock.quotesHistory.values.toList();
    costs.add(quotes[365]);
    grows.add((quotes[365] / quotes[0]) * 100 - 100);
  }
  return QuotesInfo(costs, grows);
});
