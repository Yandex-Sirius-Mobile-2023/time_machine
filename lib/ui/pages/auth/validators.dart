String? passwordValidator(String? password) {
  if (password == null || password.length < 6) {
    return "Too weak password";
  }
  return null;
}

String? emailValidator(String? email) {
  if (email == null) return "Enter E-mail";
  final bool emailValid = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
  if (!emailValid) return "Invalid email";
  return null;
}
