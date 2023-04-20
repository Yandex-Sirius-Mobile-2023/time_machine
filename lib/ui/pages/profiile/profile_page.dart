import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:time_machine/ui/pages/profiile/fragments/settings_fragment.dart';
import 'package:time_machine/ui/pages/profiile/profile_header.dart';
import 'package:time_machine/ui/pages/profiile/button_container.dart';
import 'package:time_machine/uikit/themes/ui_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'fragments/game_preview_fragment.dart';

const double headerSize = 250;
const double buttonsContainerHeight = 86;
const double containerBottomPadding = buttonsContainerHeight / 2 + 12;

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool gamePreview = true;

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).viewPadding.top;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          _ProfileBackground(),
          Positioned(
            top: topPadding,
            height: headerSize - topPadding,
            right: 0,
            left: 0,
            child: const ProfileHeader(),
          ),
          Positioned(
            top: headerSize,
            right: 0,
            left: 0,
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: PageTransitionSwitcher(
                transitionBuilder:
                    (child, primaryAnimation, secondaryAnimation) =>
                        SharedAxisTransition(
                  animation: primaryAnimation,
                  secondaryAnimation: secondaryAnimation,
                  transitionType: SharedAxisTransitionType.horizontal,
                  child: child,
                ),
                child: gamePreview
                    ? const GamePreviewFragment()
                    : const SettingsFragment(),
              ),
            ),
          ),
          Positioned(
            left: 32,
            right: 32,
            top: headerSize - buttonsContainerHeight / 2,
            height: buttonsContainerHeight,
            child: ButtonsContainer(
              rightButtonText: gamePreview
                  ? AppLocalizations.of(context)!.setSettings
                  : AppLocalizations.of(context)!.showGames,
              onSwitchPressed: switchFregments,
              leftButtonText: AppLocalizations.of(context)!.startGame,
            ),
          ),
        ],
      ),
    );
  }

  void switchFregments() {
    setState(() {
      gamePreview = !gamePreview;
    });
  }
}

class _ProfileBackground extends StatelessWidget {
  static const double gradientRotation = -0.3;

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: headerSize,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              transform: GradientRotation(gradientRotation),
              colors: [
                UIColors.cyanDark,
                UIColors.cyanBright,
              ],
            ),
          ),
        ),
        Expanded(
          child: ColoredBox(
            color: colorScheme.surface,
          ),
        ),
      ],
    );
  }
}
