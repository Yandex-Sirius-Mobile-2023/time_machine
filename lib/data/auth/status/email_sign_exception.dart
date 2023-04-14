import 'package:freezed_annotation/freezed_annotation.dart';

part "email_sign_exception.freezed.dart";

@freezed
class EmailSignException with _$EmailSignException {
  const EmailSignException._();

  const factory EmailSignException.wrondCredentials() =
      EmailWrongCredentialException;
  const factory EmailSignException.userNotFound() = EmailUserNotFoundException;
}
