import 'package:freezed_annotation/freezed_annotation.dart';

part "user.freezed.dart";

@freezed
class User with _$User {
  factory User({
    /// Nickname of user.
    required String name,

    /// Unical user code.
    required String uid,
  }) = _User;
}
