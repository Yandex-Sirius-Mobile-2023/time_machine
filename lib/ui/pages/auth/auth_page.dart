import 'package:flutter/material.dart';
import 'package:time_machine/ui/pages/auth/sign_in_form.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("Create you free account"),
                Text("To get started with Roflo-Investor, create you account"),
                SizedBox(height: 32),
                SignInForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
