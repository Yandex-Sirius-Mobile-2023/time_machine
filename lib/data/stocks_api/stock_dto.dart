import 'package:freezed_annotation/freezed_annotation.dart';

part 'stock_dto.freezed.dart';
part 'stock_dto.g.dart';

///  Api response of stock.
@freezed
abstract class StockDto with _$StockDto {
  factory StockDto({
    /// Standart stock ticker name.+
    required String ticker,

    /// Path to image logo.
    required String logo,
  }) = _StockDto;

  factory StockDto.fromJson(Map<String, dynamic> json) => _$StockDtoFromJson(json);
}
