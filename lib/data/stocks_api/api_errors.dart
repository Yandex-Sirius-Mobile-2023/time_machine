import 'package:freezed_annotation/freezed_annotation.dart';

part "api_errors.freezed.dart";

@freezed
class StockApiErrors with _$StockApiErrors {
  const factory StockApiErrors.server() = StockApiServerError;
  const factory StockApiErrors.invalidTicker() = StockApiInvalidTickerError;
}
