import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:time_machine/core/provider/auth_provider.dart';
import 'package:time_machine/data/auth/auth_service.dart';
import 'package:time_machine/data/auth/status/credential_sign_exception.dart';
import 'package:time_machine/data/auth/status/email_sign_exception.dart';
import 'package:time_machine/ui/pages/auth/commons/header_text.dart';
import 'package:time_machine/uikit/themes/text/text_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'email_password_container.dart';
import 'sign_button.dart';

Logger logger = Logger("SignInForm");

class SignInForm extends StatefulWidget {
  final Function() goToRegistration;

  const SignInForm({Key? key, required this.goToRegistration})
      : super(key: key);

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailTextContoler = TextEditingController();
  final _passwordTextContoler = TextEditingController();
  bool currentLogging = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SignHeaderText(
            message: AppLocalizations.of(context)!.loginHeaderMessage,
            bottomMessage:
                AppLocalizations.of(context)!.loginHeaderBottomMessage,
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
                emailSign(service, context);
              },
              text: AppLocalizations.of(context)!.createAccount,
            ),
          ),
          Center(
            child: TextButton(
              onPressed: widget.goToRegistration,
              child: Text(
                AppLocalizations.of(context)!.dontHaveAnAccount,
              ),
            ),
          ),
          Center(
            child: Text(
              AppLocalizations.of(context)!.or,
              style: infoStyle,
            ),
          ),
          const SizedBox(height: 8),
          Consumer(
            builder: (_, ref, __) => AuthButton(
              onPressed: () {
                final service = ref.watch(googleSignProvider);
                googleSignIn(service, context);
              },
              text: AppLocalizations.of(context)!.signWithGoogle,
            ),
          ),
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
    var localization = AppLocalizations.of(context)!;

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
          (value) => logger.info("User logged by email."),
        )
        .onError(
      (error, stackTrace) {
        if (error is! EmailSignException) throw error!;
        String errorMessage = error.when<String>(
          wrondCredentials: () => localization.wrondCredentials,
          userNotFound: () => localization.userNotFound,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
          ),
        );
      },
    );
  }

  void googleSignIn(GoogleAuthService service, BuildContext context) {
    var localization = AppLocalizations.of(context)!;

    if (currentLogging) {
      logger.info("Cancel login. User already await login results.");
      return;
    }
    currentLogging = true;
    service
        .signInWithGoogle()
        .whenComplete(() => currentLogging = false)
        .then(
          (value) => logger.info("User logged by google."),
        )
        .onError(
      (error, stackTrace) {
        if (error is PlatformException) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(localization.needGoogleService),
            ),
          );
        }
        if (error is! CredentialSignException) throw error!;
        String errorMessage = error.when<String>(
          userNotFound: () => localization.userNotFound,
          invalidCredential: () => localization.wrondCredentials,
          exsistAnother: () => localization.exsistAnother,
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
