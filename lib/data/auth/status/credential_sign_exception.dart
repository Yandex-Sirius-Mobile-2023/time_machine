import 'package:freezed_annotation/freezed_annotation.dart';

part "credential_sign_exception.freezed.dart";

@freezed
class CredentialSignException with _$CredentialSignException {
  const CredentialSignException._();

  const factory CredentialSignException.userNotFound() =
      CredentialUserNotFoundException;
  const factory CredentialSignException.invalidCredential() =
      InvalidCredentialException;
  const factory CredentialSignException.exsistAnother() =
      ExsistAnotherCredentialException;
}
