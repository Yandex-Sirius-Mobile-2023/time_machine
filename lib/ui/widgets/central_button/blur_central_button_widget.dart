// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:time_machine/ui/widgets/central_button/central_button_widget.dart';

class BlurCentralButtonWidget extends StatelessWidget {
  final bool isBlur;
  const BlurCentralButtonWidget({
    Key? key,
    required this.isBlur,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double blur = isBlur ? 30 : 0;
    return Stack(
      alignment: Alignment.center,
      children: [
        const CentralButtonWidget(),
        TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0.0, end: blur),
          duration: const Duration(milliseconds: 300),
          builder: (_, value, child) {
            return BackdropFilter(
              filter: ImageFilter.blur(sigmaX: value, sigmaY: value),
              child: child,
            );
          },
          child: const DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.transparent,
            ),
          ),
        ),
      ],
    );
  }
}
