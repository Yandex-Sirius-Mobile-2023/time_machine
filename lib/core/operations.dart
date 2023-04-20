import 'package:time_machine/core/provider/user_portfolio/user_portfolio.dart';
import '../data/models/stock.dart';
import 'model/portfolio_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:time_machine/data/models/portfolio.dart';

class ActivePortfolioNotifier extends StateNotifier<PortfolioState> {
  ActivePortfolioNotifier(super.state);

  double getBalance() {
    return state.portfolio.balance;
  }

  void addStock(Stock stock, int amount, WidgetRef ref) {
    var stocks = state.currentStep.stocks;
    stocks.update(stock, (value) => value + amount);
    var step = state.currentStep.copyWith(stocks: stocks);
    var balance = state.portfolio.balance -
        stock.quotesHistory[state.now]! * state.currentStep.stocks[stock]!;
    print("in add stock begin ${state.portfolio.balance}");
    var portfolio = state.portfolio.copyWith(balance: balance);
    state = state.copyWith(portfolio: portfolio, currentStep: step);
    print("in add stock end ${state.portfolio.balance}");
    ref.watch(userPortfolioProvider.notifier).updatePortfolio(state.portfolio);
  }

  double getTotal() {
    var total = 0.0;
    var stocks = state.currentStep.stocks;
    for (var stock in stocks.keys) {
      total += stock.quotesHistory[state.now]! * stocks[stock]!;
    }
    return total;
  }

  void goToFuture() {
    int period = state.period.getPeriod();
    var dates = state.currentStep.stocks.keys.first.quotesHistory.keys.toList();
    var now = (dates.length - 1 > dates.indexOf(state.now) + period)
        ? dates[dates.indexOf(state.now) + period]
        : dates.last;

    var currentStep = state.currentStep.copyWith(date: now);
    var steps = state.portfolio.steps;
    steps.add(currentStep);
    Portfolio portfolio = state.portfolio.copyWith(steps: steps);

    state = state.copyWith(
        now: now, portfolio: portfolio, currentStep: currentStep);
  }

  double getGrowth() {
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
    var portfolio = state.portfolio.copyWith(period: period);
    state = state.copyWith(period: period, portfolio: portfolio);
  }
}

final activePortfolioProvider = StateNotifierProvider.family<
    ActivePortfolioNotifier, PortfolioState, Portfolio>((ref, portfolio) {
      print("in StateNotifierProvider ${portfolio.balance}");

  return ActivePortfolioNotifier(PortfolioState(portfolio, portfolio.steps.last,
      portfolio.steps.last.date, portfolio.period));
});

final userPortfolioProvider =
    StateNotifierProvider<UserPortfolio, Map<int, Portfolio>>(
        (ref) => UserPortfolio([]));
