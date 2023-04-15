import 'package:flutter/material.dart';
import 'package:time_machine/ui/pages/auth/sign_in_form.dart';

import 'register_form.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final UniqueKey signFormKey = UniqueKey();
  final UniqueKey registrationFormKey = UniqueKey();

  bool nowLoging = true;

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
              children: [
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  transitionBuilder: (child, animation) => FadeTransition(
                    opacity: Tween<double>(
                      begin: 0,
                      end: 1,
                    ).animate(animation),
                    child: child,
                  ),
                  child: AnimatedSwitcher(
                    key: ValueKey(nowLoging ? "logingSwitcher" : "registerSwitcher"),
                    duration: const Duration(milliseconds: 500),
                    child: nowLoging
                        ? SignInForm(
                            key: signFormKey,
                            goToRegistration: () => setLoginStatus(false),
                          )
                        : RegisterForm(
                            key: registrationFormKey,
                            goToLogin: () => setLoginStatus(true),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void setLoginStatus(bool toLoging) {
    if (nowLoging == toLoging) return;
    nowLoging = toLoging;
    setState(() {});
  }
}
