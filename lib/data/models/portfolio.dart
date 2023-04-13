import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:time_machine/data/models/stock.dart';

part 'portfolio.freezed.dart';

@freezed

class Portfolio with _$Portfolio {
  const factory Portfolio({
    required int id,
    required DateTime createdAt,
    required List<Stock> stocks,
    required List<int> quantity,
    Map<String, int>? content,
    double? balance,
  }) = _Portfolio;
}

extension PortfolioExtension on Portfolio {
  Map<String, int> getContent(List<Stock> stocks, List<int> quantity)  {
    Map<String, int> content = {};
    stocks.forEach((stock) {
      content[stock.ticker.toString()] = quantity[stocks.indexOf(stock)];
    });
    return content;
  }

  double getBalance(List<Stock> stocks, List<int> quantity) {
    double balance = 0;
    stocks.forEach((stock) {
      balance += stock.quotesHistory.values.last * quantity[stocks.indexOf(stock)];
    });
    return balance;
  }
}