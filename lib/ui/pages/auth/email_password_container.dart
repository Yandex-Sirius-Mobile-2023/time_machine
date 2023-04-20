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
          validator: (val) => emailValidator(val),
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
          validator: passwordValidator,
        ),
        columnSpacer,
      ],
    );
  }
}
