import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:time_machine/data/models/portfolio.dart';

part 'users_portfolio.freezed.dart';

@freezed
class UsersPortfolio with _$UsersPortfolio {
  const factory UsersPortfolio(Map<int, Portfolio> portfolios) =
      _UsersPortfolio;
}
