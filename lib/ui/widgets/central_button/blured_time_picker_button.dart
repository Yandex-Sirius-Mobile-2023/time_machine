// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:circular_widgets/circular_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:time_machine/core/model/portfolio_state.dart';

import 'package:time_machine/uikit/themes/ui_colors.dart';
import 'package:time_machine/uikit/ui_consts.dart';

class BluredTimePickerButton extends StatefulWidget {
  const BluredTimePickerButton({
    Key? key,
    required this.maxSize,
    required this.onSuccess,
    required this.initIndex,
  }) : super(key: key);

  final double maxSize;
  final Function(Period) onSuccess;
  final int initIndex;

  @override
  State<BluredTimePickerButton> createState() => _BluredTimePickerButtonState();
}

class _BluredTimePickerButtonState extends State<BluredTimePickerButton> {
  int? touched;

  @override
  void initState() {
    touched = widget.initIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> intervals = UIConsts.periods(context);

    return MouseRegion(
      child: Center(
        child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0.0, end: widget.maxSize),
              duration: UIConsts.duration,
              builder: (_, value, child) {
                return CircularWidgets(
                  itemBuilder: (_, i) {
                    double angle = 0;

                    switch (i % 3) {
                      case 1:
                        angle = pi / 3;
                        break;
                      case 2:
                        angle = -pi / 3;
                        break;
                    }

                    return _ItemBluredTimePickerButton(
                      onTapDown: () => setState(() => touched = i),
                      onTapCancel: () => setState(() => touched = null),
                      angle: angle,
                      isTouched: (touched ?? -1) == i,
                      text: intervals[i],
                      size: value / 20,
                      onSuccess: () {
                        widget.onSuccess(Period.values[i]);
                      },
                    );
                  },
                  itemsLength: intervals.length,
                  config: CircularWidgetConfig(
                    itemRadius: 50,
                    centerWidgetRadius: value / 7,
                    // innerSpacing: 0,
                    drawOrder: CircularLayoutDrawOrder.centerOnTop,
                  ),
                );
              });
        }),
      ),
    );
  }
}

class _ItemBluredTimePickerButton extends StatelessWidget {
  final VoidCallback onTapDown;
  final VoidCallback onTapCancel;
  final double angle;
  final bool isTouched;
  final String text;
  final double size;
  final VoidCallback onSuccess;

  const _ItemBluredTimePickerButton({
    Key? key,
    required this.onTapDown,
    required this.onTapCancel,
    required this.angle,
    required this.isTouched,
    required this.text,
    required this.size,
    required this.onSuccess,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (t) {
        HapticFeedback.mediumImpact();
        onTapDown();
      },
      onTapCancel: onTapCancel,
      onTapUp: (details) => onSuccess(),
      child: Center(
          child: Transform.rotate(
        angle: angle,
        child: Container(
          decoration: BoxDecoration(
            color: isTouched ? UIColors.growColor : UIColors.cyanBright,
            borderRadius: BorderRadius.circular(UIConsts.paddings),
            boxShadow: isTouched
                ? [
                    const BoxShadow(
                      color: UIColors.growColor,
                      blurRadius: 20,
                    ),
                  ]
                : [],
          ),
          padding: const EdgeInsets.symmetric(
              vertical: UIConsts.paddings / 2, horizontal: UIConsts.paddings),
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: UIColors.whiteBackground,
                  fontSize: size,
                ),
            textAlign: TextAlign.center,
          ),
        ),
      )),
    );
  }
}
