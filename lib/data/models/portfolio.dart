import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:time_machine/data/models/stock.dart';
import 'package:intl/intl.dart';


part 'portfolio.freezed.dart';

@freezed

class Portfolio with _$Portfolio {
  const factory Portfolio({
    required int id,
    required DateTime createdAt,
    required List<Map<Stock,int>> stocks,
    required DateTime nowDate,
    double? balance,
  }) = _Portfolio;
}

extension PortfolioExtension on Portfolio {
  Map<String, int> getContent() {
    Map<String, int> content = {};
    for (var stock in stocks) {
      content[stock.keys.first.ticker.getName()] = stock.values.first;
    }
    return content;
  }


  double getBalance(){
    double balance = 0;
    for (var stock in stocks) {
      balance += stock.keys.first.quotesHistory[nowDate] ?? 0 * stock.values.first;
    }
    return balance;
  }
}