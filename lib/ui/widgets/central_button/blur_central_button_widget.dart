// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:time_machine/ui/widgets/central_button/central_button_widget.dart';
import 'package:time_machine/ui/widgets/central_button/central_item_button_widget.dart';
import 'package:time_machine/uikit/ui_consts.dart';

class BlurCentralButtonWidget extends StatefulWidget {
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  final List<Widget> satellites;

  const BlurCentralButtonWidget({
    Key? key,
    required this.onTap,
    required this.satellites,
    required this.onLongPress,
  }) : super(key: key);

  @override
  State<BlurCentralButtonWidget> createState() =>
      _BlurCentralButtonWidgetState();
}

class _BlurCentralButtonWidgetState extends State<BlurCentralButtonWidget> {
  String delta = "7 дн";
  double radius = 0;
  bool isBlur = false;
  void onLongPress() => setState(() {
        isBlur = !isBlur;
        widget.onLongPress();
      });

  @override
  Widget build(BuildContext context) {
    final double maxWidth =
        (MediaQuery.of(context).size.width - UIConsts.doublePaddings) * 0.7;

    return Stack(
      alignment: Alignment.center,
      children: [
        CentralButtonWidget(
          onLongPress: onLongPress,
          onTap: widget.onTap,
          getRadius: (double r) =>
              Future.microtask(() => setState(() => radius = r * 2)),
          satellites: widget.satellites,
        ),
        TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0.0, end: isBlur ? 30 : 0),
          duration: UIConsts.duration,
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
        isBlur
            ? CentralItemButtonWidget(
                text: delta,
                size: isBlur ? maxWidth : radius,
                onTap: widget.onTap,
                onLongPress: onLongPress,
                isBlur: isBlur,
              )
            : const SizedBox(),
      ],
    );
  }
}
