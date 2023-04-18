// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:time_machine/ui/widgets/central_button/central_button_widget.dart';
import 'package:time_machine/ui/widgets/central_button/central_item_button_widget.dart';
import 'package:time_machine/uikit/ui_consts.dart';

class BlurCentralButtonWidget extends StatefulWidget {
  final bool isBlur;
  final VoidCallback onTap;

  const BlurCentralButtonWidget({
    Key? key,
    required this.isBlur,
    required this.onTap,
  }) : super(key: key);

  @override
  State<BlurCentralButtonWidget> createState() =>
      _BlurCentralButtonWidgetState();
}

class _BlurCentralButtonWidgetState extends State<BlurCentralButtonWidget> {
  String delta = "7 дн";
  double radius = 0;

  @override
  Widget build(BuildContext context) {
    final double maxWidth =
        (MediaQuery.of(context).size.width - UIConsts.doublePaddings) * 0.7;
    final double blur = widget.isBlur ? 30 : 0;

    return Stack(
      alignment: Alignment.center,
      children: [
        CentralButtonWidget(
          onTap: widget.onTap,
          getRadius: (double r) =>
              Future.microtask(() => setState(() => radius = r * 2)),
        ),
        TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0.0, end: blur),
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
        widget.isBlur
            ? CentralItemButtonWidget(
                text: delta,
                size: widget.isBlur ? maxWidth : radius,
                onLongTap: widget.onTap,
                isBlur: widget.isBlur,
                onTap: () {},
              )
            : const SizedBox(),
      ],
    );
  }
}
