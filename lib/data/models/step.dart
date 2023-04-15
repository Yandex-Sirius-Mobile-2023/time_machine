import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:time_machine/data/models/stock.dart';

part 'step.freezed.dart';

@freezed
class Step with _$Step {
  const factory Step({
    Map<Stock, int>? stocks,
  }) = _Step;
}
