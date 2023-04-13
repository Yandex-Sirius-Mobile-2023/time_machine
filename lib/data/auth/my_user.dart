import 'package:freezed_annotation/freezed_annotation.dart';

part "my_user.freezed.dart";

@freezed
class MyUser with _$MyUser {
  factory MyUser({
    /// Nickname of user.
    required String name,

    /// Unical user code.
    required String uid,
  }) = _MyUser;
}
