import 'package:flutter/material.dart';
import 'package:time_machine/uikit/themes/text/text_decorations.dart';
import 'package:time_machine/uikit/themes/text/text_style.dart';

import 'validators.dart';

class EmailPasswordContainer extends StatelessWidget {
  static const String enterEmailAdressLabel = "Your email addres";
  static const String enterEmailAdressHint = "Enter email addres";
  static const String enterPasswordLabel = "Your password";
  static const String enterPasswordHint = "Enter password";
  static const String createAccountText = "Create account text";
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
        const Text(
          enterEmailAdressLabel,
          style: infoStyle,
        ),
        smallSpacer,
        TextFormField(
          controller: emailTextContoler,
          decoration: inputFormDecoration(context).copyWith(
            hintText: enterEmailAdressHint,
          ),
          validator: (val) => emailValidator(val),
        ),
        columnSpacer,
        // Password input
        const Text(
          enterPasswordLabel,
          style: infoStyle,
        ),
        smallSpacer,
        TextFormField(
          controller: passwordTextContoler,
          obscureText: true,
          enableSuggestions: false,
          autocorrect: false,
          decoration: inputFormDecoration(context).copyWith(
            hintText: enterPasswordHint,
          ),
          validator: passwordValidator,
        ),
        columnSpacer,
      ],
    );
  }
}
