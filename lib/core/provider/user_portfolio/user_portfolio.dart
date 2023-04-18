import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:time_machine/data/models/portfolio.dart';
import 'package:time_machine/data/models/step.dart';
import 'package:time_machine/data/models/stock.dart';
import 'package:time_machine/data/services/stock_service_impl.dart';

class UserPortfolio extends StateNotifier<Map<int,Portfolio>> {

  UserPortfolio(List<Portfolio> portfolios) : super({}) {
    for (var portfolio in portfolios) {
      state[portfolio.id] = portfolio;
    }
  }

  Future<int> createPortfolio(List<StockTicker> tickers) async {
    final now = DateTime.now();
    final id = now.microsecondsSinceEpoch;
    Map<Stock,int> stocks = {};
    final service = StockServiceImpl();
    for (var ticker in tickers){
      final stock = await service.getStock(ticker);
      stocks[stock] = 0;
    }
    List<Step> steps = [Step(stocks)];
    state[id] = Portfolio(id, now, steps, now, 1000000.0,0.0);

    return id;
  }

  Portfolio getPortfolio(int id) {
    return state[id]!;
  }

  void updatePortfolio(Portfolio portfolio) {
    state[portfolio.id] = portfolio;
  }
}