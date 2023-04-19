import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:time_machine/data/models/step.dart';

part 'portfolio.freezed.dart';

@Freezed(makeCollectionsUnmodifiable: false)
class Portfolio with _$Portfolio {
  const factory Portfolio(
    int id,
    DateTime createdAt,
    List<Step> steps,
    DateTime nowDate,
    double balance,
    double totalValue,
    Period period,
  ) = _Portfolio;
}

enum Period {
  day,
  week,
  month,
  quatile,
  semiYear,
  year,
}

extension PeriodExtension on Period {
  int getPeriod() {
    switch (this) {
      case Period.day:
        return 1;
      case Period.week:
        return 7;
      case Period.month:
        return 30;
      case Period.quatile:
        return 120;
      case Period.semiYear:
        return 180;
      case Period.year:
        return 365;
    }
  }
}
