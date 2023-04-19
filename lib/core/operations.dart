import 'package:time_machine/core/provider/user_portfolio/user_portfolio.dart';
import 'package:time_machine/data/models/step.dart';
import '../data/models/stock.dart';
import 'model/portfolio_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:time_machine/data/models/portfolio.dart';

class ActivePortfolioNotifier extends StateNotifier<PortfolioState> {
  ActivePortfolioNotifier(super.state);

  void addStock(Stock stock, int amount) {
    state = PortfolioState(
        state.portfolio,
        Step(state.currentStep.stocks..update(stock, (value) => value + amount),
            state.portfolio.nowDate));
  }

  //TODO add removeStock
  void removeStock(Stock stock) {
    state = PortfolioState(state.portfolio,
        Step(state.currentStep.stocks..remove(stock), state.portfolio.nowDate));
  }

  void goToFuture(int period) {
    var dates = state.currentStep.stocks.keys.first.quotesHistory.keys.toList();
    state.portfolio = state.portfolio.copyWith(
        nowDate:
            (dates.length - 1 > dates.indexOf(state.portfolio.nowDate) + period)
                ? dates[dates.indexOf(state.portfolio.nowDate) + period]
                : dates.last);
  }

  double getGrowth(int period) {
    double previous = 0;
    for (var stock in state.currentStep.stocks.keys) {
      int quantity = state.currentStep.stocks[stock]!;
      double quote = stock.quotesHistory.values.toList()[
          stock.quotesHistory.keys.toList().indexOf(state.portfolio.nowDate) -
              period];
      previous += quantity * quote;
    }

    return (previous == 0)
        ? 0
        : (state.portfolio.totalValue - previous) / previous * 100;
  }

  void updateBalanceAndTotalValue() {
    double credit = 0;
    double debit = 0;
    for (var stock in state.currentStep.stocks.keys) {
      double quote = stock.quotesHistory[state.portfolio.nowDate]!;

      credit += quote * state.currentStep.stocks[stock]!;

      debit += quote * state.currentStep.stocks[stock]!;
    }

    state.portfolio = state.portfolio
        .copyWith(balance: state.portfolio.balance - credit, totalValue: debit);
  }

  void commit(currentStep) {
    state.portfolio.steps.add(currentStep);
    state.currentStep = Step(state.currentStep.stocks, state.portfolio.nowDate);
    updateBalanceAndTotalValue();
    state = PortfolioState(state.portfolio, state.currentStep);
  }
}

final activePortfolioProvider = StateNotifierProvider.family<
    ActivePortfolioNotifier, PortfolioState, Portfolio>(
  (ref, portfolio) =>
      ActivePortfolioNotifier(PortfolioState(portfolio, portfolio.steps.last)),
);

final userPortfolioProvider =
    StateNotifierProvider<UserPortfolio, Map<int, Portfolio>>(
        (ref) => UserPortfolio([]));

final portfolioGraphDataProvider =
    StateProvider.family<List<List<double>>, Portfolio>((ref, portfolio) {
  final stockQuantity = portfolio.steps.last.stocks;
  final stocks = stockQuantity.keys.toList();
  final startDate =
      stocks.first.quotesHistory.keys.toList().indexOf(portfolio.nowDate);
  final x =
      List.generate(stocks.first.quotesHistory.values.length, (index) => index)
          .sublist(startDate - 50, startDate);
  //TODO change upperDate ->
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
