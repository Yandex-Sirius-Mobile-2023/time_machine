import 'package:time_machine/core/provider/user_portfolio/user_portfolio.dart';
import 'package:time_machine/data/models/step.dart';
import '../data/models/stock.dart';
import 'model/portfolio_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:time_machine/data/models/portfolio.dart';

class ActivePortfolioNotifier extends StateNotifier<PortfolioState> {
  ActivePortfolioNotifier(super.state) {
    print('constructor: $hashCode');
  }

  void addStock(Stock stock, int amount) {
    // updateTotalValue();
    Portfolio portfolio = state.portfolio.copyWith(
        balance: state.portfolio.balance -
            stock.quotesHistory[state.now]! * state.currentStep.stocks[stock]!);

    var stocks = state.currentStep.stocks;
    stocks.update(stock, (value) => value + amount);

    Step step = state.currentStep.copyWith(stocks: stocks);

    state = state.copyWith(portfolio: portfolio, currentStep: step);

    /*
    remove unfreezed
    remove mutable state
    remove update of balance before goToFuture
    updatePortfolio change for state = state.copyWith
    each method of stateNotifier only one overwrite for
    write to get total from currentStep
    move nowDate and period for PortfolioState from Portfolio
    check that hashcode portfolio for next round will be the same
     */

    print(
        'addStock ($hashCode) ${state.portfolio.balance} -> ${state.portfolio.hashCode}');
  }

  double getTotal() {
    var total = 0.0;
    var stocks = state.currentStep.stocks;
    for (var stock in stocks.keys) {
      total += stock.quotesHistory[state.now]! * stocks[stock]!;
    }
    return total;
  }

  // @override
  // set state(PortfolioState value) {
  //   super.state = value;
  //   print('update ($hashCode):\nprev: ${state.portfolio.balance}\nnext: ${value.portfolio.balance}\n');
  // }

  void goToFuture() {
    int period = state.period.getPeriod();
    var dates = state.currentStep.stocks.keys.first.quotesHistory.keys.toList();
    var steps = state.portfolio.steps;
    steps.add(state.currentStep);
    Portfolio portfolio = state.portfolio.copyWith(steps: steps);

    state = state.copyWith(
        now: (dates.length - 1 > dates.indexOf(state.now) + period)
            ? dates[dates.indexOf(state.now) + period]
            : dates.last,
        portfolio: portfolio,
        currentStep: state.currentStep.copyWith(date: state.now));
  }

  double getGrowth() {
    print('getGrowth ${state.portfolio.balance}');
    int period = state.period.getPeriod();
    double previous = 0;
    for (var stock in state.currentStep.stocks.keys) {
      int quantity = state.currentStep.stocks[stock]!;
      double quote = stock.quotesHistory.values.toList()[
          stock.quotesHistory.keys.toList().indexOf(state.now) - period];
      previous += quantity * quote;
    }

    var totalValue = getTotal();

    return (previous == 0) ? 0 : (totalValue - previous) / previous * 100;
  }

  List<List<double>> getGraphData() {
    final stockQuantity = state.currentStep.stocks;
    final stocks = stockQuantity.keys.toList();
    final startDate =
        stocks.first.quotesHistory.keys.toList().indexOf(state.now);
    final x = List.generate(
            stocks.first.quotesHistory.values.length, (index) => index)
        .sublist(startDate - state.period.getPeriod(), startDate);
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
  }

  void updatePeriod(Period period) {
    state = state.copyWith(period: period);
  }
}

final activePortfolioProvider = StateNotifierProvider.family<
    ActivePortfolioNotifier, PortfolioState, Portfolio>(
  (ref, portfolio) => ActivePortfolioNotifier(PortfolioState(
      portfolio,
      portfolio.steps.last,
      DateTime.parse("2011-01-03 00:00:00"),
      Period.week)),
);

final userPortfolioProvider =
    StateNotifierProvider<UserPortfolio, Map<int, Portfolio>>(
        (ref) => UserPortfolio([]));

// final portfolioGraphDataProvider =
//     StateProvider.family<List<List<double>>, Portfolio>((ref, portfolio) {
//
// });


