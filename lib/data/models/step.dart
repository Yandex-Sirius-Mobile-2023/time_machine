import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:time_machine/data/models/stock.dart';

part 'step.freezed.dart';

@Freezed(makeCollectionsUnmodifiable: false)
class Step with _$Step {
  factory Step(Map<Stock, int> stocks, DateTime date) = _Step;
}
