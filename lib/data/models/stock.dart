import 'package:freezed_annotation/freezed_annotation.dart';

part 'stock.freezed.dart';
part 'stock.g.dart';

enum StockTicker {
  AAPL,
  AMZN,
  BAC,
  BRK_A,
  DIS,
  HD,
  JNJ,
  JPM,
  MA,
  MSFT,
  NVDA,
  PG,
  UNH,
  V,
  XOM,
}

@freezed
class Stock with _$Stock {
  const factory Stock(
      {required StockTicker ticker,
      required Map<DateTime, double> quotesHistory}) = _Stock;

  factory Stock.fromJson(Map<String, dynamic> json) => _$StockFromJson(json);
}

extension StockExtension on StockTicker {
  String getName() {
    switch (this) {
      case StockTicker.AAPL:
        return "Apple";
      case StockTicker.AMZN:
        return "Amazon";
      case StockTicker.BAC:
        return "Bank of America";
      case StockTicker.BRK_A:
        return "Berkshire Hathaway";
      case StockTicker.DIS:
        return "Walt Disney";
      case StockTicker.HD:
        return "Home Depot";
      case StockTicker.JNJ:
        return "Johnson & Jonhson";
      case StockTicker.JPM:
        return "JPMorgan Chase";
      case StockTicker.MA:
        return "Mastercard";
      case StockTicker.MSFT:
        return "Microsoft Corporation";
      case StockTicker.NVDA:
        return "Nvidia";
      case StockTicker.PG:
        return "Procter & Gamble Company";
      case StockTicker.UNH:
        return "UnitedHealth Group";
      case StockTicker.V:
        return "Visa";
      case StockTicker.XOM:
        return "Exxon Mobil";
    }
  }
}
