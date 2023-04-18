import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:time_machine/data/models/stock.dart';

part 'stock_info_state.freezed.dart';

@freezed
class StockInfoState with _$StockInfoState {
  const factory StockInfoState.loading() = StockInfoStateLoading;
  const factory StockInfoState.content({
    required Stock stock,
    required int boughtStockCount,
  }) = StockInfoStateContent;
}
