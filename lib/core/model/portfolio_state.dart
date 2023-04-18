import 'package:time_machine/data/models/portfolio.dart';
import 'package:time_machine/data/models/step.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'portfolio_state.freezed.dart';

@freezed
class PortfolioState with _$PortfolioState {
  const factory PortfolioState(Portfolio portfolio, Step currentStep) =
      _PortfolioState;
}