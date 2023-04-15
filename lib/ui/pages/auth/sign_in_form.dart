import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:time_machine/core/provider/auth_provider.dart';
import 'package:time_machine/data/auth/auth_service.dart';
import 'package:time_machine/data/auth/status/email_sign_exception.dart';

Logger logger = Logger("SignInForm");

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

class SignInForm extends StatefulWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
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
  final _emailTextContoler = TextEditingController();
  final _passwordTextContoler = TextEditingController();
  bool currentLogging = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Email input
          const Text(enterEmailAdressLabel),
          smallSpacer,
          TextFormField(
            controller: _emailTextContoler,
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
            controller: _passwordTextContoler,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: textDecoration.copyWith(
              hintText: enterPasswordHint,
            ),
            validator: passwordValidator,
          ),
          columnSpacer,
          Consumer(
            builder: (_, ref, __) => SignButton(
              onPressed: () {
                if (!_formKey.currentState!.validate()) return;
                var service = ref.read(emailSignProvider);
                emailSign(service, context);
              },
              createAccountText: createAccountText,
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _passwordTextContoler.dispose();
    _emailTextContoler.dispose();
    super.dispose();
  }

  void emailSign(EmailAuthService authService, BuildContext context) {
    if (currentLogging) {
      logger.info("Cancel login. User already await login results.");
      return;
    }
    currentLogging = true;
    authService
        .signInEmailAndPassword(
          email: _emailTextContoler.text,
          password: _passwordTextContoler.text,
        )
        // Free login status
        .whenComplete(() => currentLogging = false)
        .then(
          (value) => logger.info("User logged."),
        )
        .onError(
      (error, stackTrace) {
        if (error is! EmailSignException) throw error!;
        String errorMessage = error.when<String>(
          wrondCredentials: () => "Wrong credentials",
          userNotFound: () => "User not found",
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
          ),
        );
      },
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
