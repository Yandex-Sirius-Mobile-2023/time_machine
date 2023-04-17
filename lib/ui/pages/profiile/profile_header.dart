import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          Flexible(
            flex: 3,
            child: Center(child: _GreetingsMessage()),
          ),
          Flexible(
            flex: 2,
            child: SizedBox.expand(
              child: ClipOval(
                child: SizedBox(
                  child: ColoredBox(
                    color: Colors.white,
                  ),
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
  static const String greetingsText = "Welcome to ";
  static const String appText = "Time Machine";

  const _GreetingsMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: const TextSpan(
        style: TextStyle(fontSize: 30),
        children: [
          TextSpan(text: "$greetingsText\n"),
          TextSpan(
            text: appText,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
