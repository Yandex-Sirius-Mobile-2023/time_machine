
import 'package:time_machine/data/models/step.dart';
import '../data/models/stock.dart';
import 'model/portfolio_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:time_machine/data/models/portfolio.dart';

class ActivePortfolioNotifier extends StateNotifier<PortfolioState>{
  ActivePortfolioNotifier(super.state);

  void initPortfolio(Portfolio portfolio, Step step) {
    state = PortfolioState(portfolio, Step(stocks: step.stocks));
  }

  void addStock(Stock stock, int amount) {
    state = PortfolioState(state.portfolio, Step(stocks: state.currentStep.stocks!..addAll({stock: amount})));
  }

  void removeStock(Stock stock) {
    state = PortfolioState(state.portfolio, Step(stocks: state.currentStep.stocks!..remove(stock)));
  }

  void updateStock(Stock stock, int amount) {
    state = PortfolioState(state.portfolio, Step(stocks: state.currentStep.stocks!..update(stock, (value) => amount)));
  }

  void updateBalance(double balance) {
    state = PortfolioState(state.portfolio, Step(stocks: state.currentStep.stocks!));
  }

}


final activePortfolioProvider = StateNotifierProvider.family<ActivePortfolioNotifier, PortfolioState,Portfolio>(
      (ref, portfolio) => ActivePortfolioNotifier(PortfolioState(portfolio, Step(stocks: null))),
);