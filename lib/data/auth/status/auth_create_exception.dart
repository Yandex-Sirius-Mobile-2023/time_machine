import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_create_exception.freezed.dart';

@freezed
class AuthCreateException with _$AuthCreateException {
  const AuthCreateException._();

  const factory AuthCreateException.usedEmail() = UsedEmailCreateException;
  const factory AuthCreateException.invalidEmail() = InvalidEmailCreateException;
  const factory AuthCreateException.emailAlreadyUsed() =
      EmailAlreadyUsedCreateException;
  const factory AuthCreateException.weakPassword() = WeakPasswordCreateException;
}
