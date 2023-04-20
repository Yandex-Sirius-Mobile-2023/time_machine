enum PasswordValid {
  valid,
  tooWeakPassword,
}

PasswordValid passwordValidator(String? password) {
  if (password == null || password.length < 6) {
    return PasswordValid.tooWeakPassword;
  }
  return PasswordValid.valid;
}

enum EmailValid {
  valid,
  empty,
  invalidFormat,
}

EmailValid emailValidator(String? email) {
  if (email == null) return EmailValid.empty;
  final bool emailValid = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
  if (!emailValid) return EmailValid.invalidFormat;
  return EmailValid.valid;
}
