import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:time_machine/core/provider/theme_provider.dart';
import 'package:time_machine/ui/pages/profiile/profile_header.dart';
import 'package:time_machine/ui/pages/profiile/settings_container.dart';
import 'package:time_machine/uikit/themes/dark_theme.dart';
import 'package:time_machine/uikit/themes/light_theme.dart';
import 'package:time_machine/uikit/themes/ui_colors.dart';

import 'game_preview.dart';

const double headerSize = 250;
const double buttonsContainerHeight = 86;

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

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
          const Positioned(
            left: 32,
            right: 32,
            top: headerSize - buttonsContainerHeight / 2,
            height: buttonsContainerHeight,
            child: SettingsContainer(),
          ),
          const Positioned(
            top: headerSize + buttonsContainerHeight / 2 + 24,
            right: 0,
            left: 0,
            bottom: 0,
            child: GamePreview(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ProviderScope.containerOf(context)
            .read(themeProvider.notifier)
            .toogleTheme,
      ),
    );
  }
}

class _ProfileBackground extends StatelessWidget {
  static const double gradientRotation = -0.3;

  @override
  Widget build(BuildContext context) {
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
        const Expanded(
          child: ColoredBox(
            color: UIColors.whiteBackground,
          ),
        ),
      ],
    );
  }
}
