// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Stock _$$_StockFromJson(Map<String, dynamic> json) => _$_Stock(
      ticker: $enumDecode(_$StockTickerEnumMap, json['ticker']),
      quotesHistory: (json['quotesHistory'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(DateTime.parse(k), (e as num).toDouble()),
      ),
    );

Map<String, dynamic> _$$_StockToJson(_$_Stock instance) => <String, dynamic>{
      'ticker': _$StockTickerEnumMap[instance.ticker]!,
      'quotesHistory': instance.quotesHistory
          .map((k, e) => MapEntry(k.toIso8601String(), e)),
    };

const _$StockTickerEnumMap = {
  StockTicker.AAPL: 'AAPL',
  StockTicker.AMZN: 'AMZN',
  StockTicker.BAC: 'BAC',
  StockTicker.BRK_A: 'BRK_A',
  StockTicker.DIS: 'DIS',
  StockTicker.HD: 'HD',
  StockTicker.JNJ: 'JNJ',
  StockTicker.JPM: 'JPM',
  StockTicker.MA: 'MA',
  StockTicker.MSFT: 'MSFT',
  StockTicker.NVDA: 'NVDA',
  StockTicker.PG: 'PG',
  StockTicker.UNH: 'UNH',
  StockTicker.V: 'V',
  StockTicker.XOM: 'XOM',
};
