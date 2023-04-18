import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:time_machine/core/provider/auth_provider.dart';
import 'package:time_machine/data/auth/auth_service.dart';
import 'package:time_machine/data/auth/status/auth_create_exception.dart';
import 'package:time_machine/ui/pages/auth/commons/header_text.dart';

import 'email_password_container.dart';
import 'sign_button.dart';

Logger logger = Logger("SignInForm");

class RegisterForm extends StatefulWidget {
  final Function() goToLogin;

  const RegisterForm({Key? key, required this.goToLogin}) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  static const String registerAccountText = "Register account";
  static const String headerMessage = "Create you free account!";
  static const String headerBottomMessage =
      "To get started with Roflo-Investor, create you account.";

  final _formKey = GlobalKey<FormState>();
  final _emailTextContoler = TextEditingController();
  final _passwordTextContoler = TextEditingController();
  bool currentCreating = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SignHeaderText(
            message: headerMessage,
            bottomMessage: headerBottomMessage,
          ),
          const SizedBox(height: 32),
          EmailPasswordContainer(
            emailTextContoler: _emailTextContoler,
            passwordTextContoler: _passwordTextContoler,
          ),
          const SizedBox(height: 32),
          Consumer(
            builder: (_, ref, __) => AuthButton(
              onPressed: () {
                if (!_formKey.currentState!.validate()) return;
                var service = ref.read(emailSignProvider);
                emailCreate(service, context);
              },
              text: registerAccountText,
            ),
          ),
          Center(
            child: TextButton(
              onPressed: widget.goToLogin,
              child: const Text("Already have account?"),
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

  void emailCreate(EmailAuthService authService, BuildContext context) {
    if (currentCreating) {
      logger.info("Cancel create. User already await create results.");
      return;
    }
    currentCreating = true;
    authService
        .createWithEmailAndPassword(
          email: _emailTextContoler.text,
          password: _passwordTextContoler.text,
        )
        // Free login status
        .whenComplete(() => currentCreating = false)
        .then(
          (value) => logger.info("User create account."),
        )
        .onError(
      (error, stackTrace) {
        if (error is! AuthCreateException) throw error!;
        String errorMessage = error.when<String>(
          invalidEmail: () => "Invalid email format",
          emailAlreadyUsed: () => "Email already used",
          weakPassword: () => "Password to weak",
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
