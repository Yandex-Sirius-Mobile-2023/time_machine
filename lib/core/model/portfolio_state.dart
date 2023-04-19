import 'package:time_machine/data/models/portfolio.dart';
import 'package:time_machine/data/models/step.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'portfolio_state.freezed.dart';

@freezed
class PortfolioState with _$PortfolioState {
  const factory PortfolioState(
          Portfolio portfolio, Step currentStep, DateTime now, Period period) =
      _PortfolioState;
}




enum Period {
  day,
  week,
  month,
  quarter,
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
      case Period.quarter:
        return 120;
      case Period.semiYear:
        return 180;
      case Period.year:
        return 365;
    }
  }
}
