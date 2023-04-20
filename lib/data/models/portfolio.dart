import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:time_machine/core/model/portfolio_state.dart';
import 'package:time_machine/data/models/step.dart';

part 'portfolio.freezed.dart';

@Freezed(makeCollectionsUnmodifiable: false)
class Portfolio with _$Portfolio {
  const factory Portfolio(
    int id,
    DateTime createdAt,
    List<Step> steps,
    // DateTime nowDate, //
    double balance,
    // double totalValue, //???????
    Period period,
  ) = _Portfolio;
}
