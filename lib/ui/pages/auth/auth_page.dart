import 'dart:async';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:time_machine/app.dart';
import 'package:time_machine/core/provider/auth_provider.dart';
import 'package:time_machine/ui/pages/auth/sign_in_form.dart';

import 'register_form.dart';

Logger logger = Logger("AuthPage");

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final UniqueKey signFormKey = UniqueKey();
  final UniqueKey registrationFormKey = UniqueKey();

  bool nowLoging = true;
  late StreamSubscription subscription = const Stream.empty().listen((event) {});

  @override
  Widget build(BuildContext context) {
    // Subscribe on auth sign in events.
    subscription.cancel();
    var firebaseAuth = ProviderScope.containerOf(context).read(
      firebaseAuthProvider,
    );
    subscription = firebaseAuth.listenUpdates(
      () {
        if (firebaseAuth.user != null) succesfulLoginAction(context);
      },
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 0),
          child: Center(
            child: PageTransitionSwitcher(
              duration: const Duration(milliseconds: 500),
              reverse: nowLoging,
              transitionBuilder: (child, primaryAnimation, secondaryAnimation) =>
                  SharedAxisTransition(
                animation: primaryAnimation,
                secondaryAnimation: secondaryAnimation,
                transitionType: SharedAxisTransitionType.vertical,
                child: child,
              ),
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
        ),
      ),
    );
  }

  void setLoginStatus(bool toLoging) {
    if (nowLoging == toLoging) return;
    nowLoging = toLoging;
    setState(() {});
  }

  void succesfulLoginAction(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(AppRoutes.chooseStockURL);
  }
}
