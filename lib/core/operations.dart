import 'package:time_machine/core/provider/user_portfolio/user_portfolio.dart';
import 'package:time_machine/data/models/step.dart';
import '../data/models/stock.dart';
import 'model/portfolio_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:time_machine/data/models/portfolio.dart';

class ActivePortfolioNotifier extends StateNotifier<PortfolioState> {
  ActivePortfolioNotifier(super.state);

  void addStock(Stock stock, int amount) {
    state = PortfolioState(state.portfolio,
        Step(state.currentStep.stocks..addAll({stock: amount})));
  }

  void removeStock(Stock stock) {
    state = PortfolioState(
        state.portfolio, Step(state.currentStep.stocks..remove(stock)));
  }

  void updateStock(Stock stock, int amount) {}

  void updateBalance(double balance) {
    state = PortfolioState(state.portfolio, Step(state.currentStep.stocks));
  }
}

final activePortfolioProvider = StateNotifierProvider.family<
    ActivePortfolioNotifier, PortfolioState, Portfolio>(
  (ref, portfolio) =>
      ActivePortfolioNotifier(PortfolioState(portfolio, Step({}))),
);

final userPortfolioProvider =
    StateNotifierProvider<UserPortfolio, Map<int, Portfolio>>(
        (ref) => UserPortfolio([]));

final portfolioGraphDataProvider =
    StateProvider.family<List<List<double>>, Portfolio>((ref, portfolio) {
  final stockQuantity = portfolio.steps.last.stocks;
  final stocks = stockQuantity.keys.toList();
  final x =
      List.generate(stocks.first.quotesHistory.values.length, (index) => index)
          .sublist(0, 50); //TODO: пересчитывать на текущий день
  List<List<double>> graphData = [];
  for (int i in x) {
    double y = 0;
    for (Stock stock in stocks) {
      final quotes = stock.quotesHistory.values.toList();
      y += quotes[i] * stockQuantity[stock]!;
    }
    graphData.add([i.toDouble(), y]);
  }
  return graphData;
});
