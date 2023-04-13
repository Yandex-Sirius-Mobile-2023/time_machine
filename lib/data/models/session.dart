import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:time_machine/data/models/portfolio.dart';

part 'session.freezed.dart';


@freezed
class Session with _$Session {
  const factory Session({
    required String token,
    required int accountId,
    required DateTime createdAt,
    DateTime? expiredAt,
    List<Portfolio>? portfolios,
  }) = _Session;
}

