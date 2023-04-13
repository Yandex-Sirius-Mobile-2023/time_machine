import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:time_machine/data/models/session.dart';

part 'account.freezed.dart';


@freezed
class Account with _$Account {
  const factory Account({
    required int id,
    required String name,
    required String email,
    required String password,
    List<Session>? sessions,
  }) = _Account;
}


