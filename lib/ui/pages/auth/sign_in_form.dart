import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:time_machine/core/provider/auth_provider.dart';

String? passwordValidator(String? password) {
  if (password == null || password.length < 6) {
    return "Too weak password";
  }
  return null;
}

String? emailValidator(String? email) {
  if (email == null) return "Enter E-mail";
  final bool emailValid =
      RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(email);
  if (!emailValid) return "Invalid email";
  return null;
}

class SignInForm extends ConsumerWidget {
  static const String enterEmailAdressLabel = "Your email addres";
  static const String enterEmailAdressHint = "Enter email addres";
  static const String enterPasswordLabel = "Your password";
  static const String enterPasswordHint = "Enter password";
  static const String createAccountText = "Create account text";
  static const columnSpacer = SizedBox(height: 16);
  static const smallSpacer = SizedBox(height: 4);
  static const textDecoration = InputDecoration(
    filled: true,
    fillColor: Colors.green,
    border: OutlineInputBorder(),
  );

  final _formKey = GlobalKey<FormState>();

  SignInForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Email input
          const Text(enterEmailAdressLabel),
          smallSpacer,
          TextFormField(
            decoration: textDecoration.copyWith(
              hintText: enterEmailAdressHint,
            ),
            validator: (val) => emailValidator(val),
          ),
          columnSpacer,
          // Password input
          const Text(enterPasswordLabel),
          smallSpacer,
          TextFormField(
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: textDecoration.copyWith(
              hintText: enterPasswordHint,
            ),
            validator: passwordValidator,
          ),
          columnSpacer,
          SignButton(
            onPressed: () {
              print("hello_world");
              if (!_formKey.currentState!.validate()) return;
              var service = ref.read(emailSignProvider);
              service.createWithEmailAndPassword(
                email: "axcdddsdds@mail.ru",
                password: "21312331",
              );
            },
            createAccountText: createAccountText,
          )
        ],
      ),
    );
  }
}

class SignButton extends ConsumerWidget {
  final Function() onPressed;
  const SignButton({
    required this.onPressed,
    super.key,
    required this.createAccountText,
  });

  final String createAccountText;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: FractionallySizedBox(
        widthFactor: 0.6,
        child: ElevatedButton(
          onPressed: onPressed,
          child: Text(createAccountText),
        ),
      ),
    );
  }
}
