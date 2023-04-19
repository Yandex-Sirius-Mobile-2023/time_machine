import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Flexible(
            flex: 3,
            child: Center(child: _GreetingsMessage()),
          ),
          Flexible(
            flex: 2,
            child: Center(
              child: SizedBox(
                height: 86,
                width: 86,
                child: ClipOval(
                  child: Image.asset("assets/demo_icon.png"),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GreetingsMessage extends StatelessWidget {
  static const String appText = "Time Machine";

  const _GreetingsMessage();

  @override
  Widget build(BuildContext context) {
    String greetingsText = AppLocalizations.of(context)!.welcome;

    return RichText(
      text: TextSpan(
        style: const TextStyle(fontSize: 30),
        children: [
          TextSpan(text: "$greetingsText\n"),
          const TextSpan(
            text: appText,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
