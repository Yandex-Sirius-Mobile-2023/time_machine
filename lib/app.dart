import 'package:flutter/material.dart';
import 'package:time_machine/uikit/ui_text_theme.dart';
import 'package:time_machine/uikit/ui_theme.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: darkScheme,
        textTheme: textTheme,
      ),
      // home: const SomeHomePage(),
    );
  }
}
