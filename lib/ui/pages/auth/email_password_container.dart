import 'package:flutter/material.dart';
import 'package:time_machine/uikit/themes/text/text_decorations.dart';
import 'package:time_machine/uikit/themes/text/text_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'validators.dart';

class EmailPasswordContainer extends StatelessWidget {
  static const columnSpacer = SizedBox(height: 16);
  static const smallSpacer = SizedBox(height: 4);

  final TextEditingController emailTextContoler;
  final TextEditingController passwordTextContoler;

  const EmailPasswordContainer(
      {super.key,
      required this.emailTextContoler,
      required this.passwordTextContoler});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Email input
        Text(
          AppLocalizations.of(context)!.yourEmailAdress,
          style: infoStyle,
        ),
        smallSpacer,
        TextFormField(
          controller: emailTextContoler,
          decoration: inputFormDecoration(context).copyWith(
            hintText: AppLocalizations.of(context)!.enterEmailAdress,
          ),
          validator: (val) => emailValidatorText(
            valid: emailValidator(val),
            localizations: AppLocalizations.of(context)!,
          ),
        ),
        columnSpacer,
        // Password input
        Text(
          AppLocalizations.of(context)!.yourPassword,
          style: infoStyle,
        ),
        smallSpacer,
        TextFormField(
          controller: passwordTextContoler,
          obscureText: true,
          enableSuggestions: false,
          autocorrect: false,
          decoration: inputFormDecoration(context).copyWith(
            hintText: AppLocalizations.of(context)!.enterPassword,
          ),
          validator: (text) => passwordValidatorText(
            valid: passwordValidator(text),
            localizations: AppLocalizations.of(context)!,
          ),
        ),
        columnSpacer,
      ],
    );
  }

  String? passwordValidatorText({
    required PasswordValid valid,
    required AppLocalizations localizations,
  }) {
    if (valid == PasswordValid.tooWeakPassword) {
      return localizations.tooWeakPassword;
    }
    return null;
  }

  String? emailValidatorText({
    required EmailValid valid,
    required AppLocalizations localizations,
  }) {
    switch (valid) {
      case EmailValid.invalidFormat:
        return localizations.invalidEmail;
      case EmailValid.empty:
        return localizations.emptyEmail;
      default:
        return null;
    }
  }
}
