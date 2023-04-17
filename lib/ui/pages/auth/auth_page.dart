import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
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
        if (firebaseAuth.user != null) succesfulLoginAction();
      },
    );

    return Scaffold(
      body: Center(
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
            ],
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

  void succesfulLoginAction() {
    logger.info("Succesful login");
  }
}
