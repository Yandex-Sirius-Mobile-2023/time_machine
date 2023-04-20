// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:time_machine/core/model/portfolio_state.dart';
import 'package:time_machine/core/operations.dart';

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

    return Consumer(builder: (BuildContext context, WidgetRef ref, _) {
      var portfolio =
          ref.watch(userPortfolioProvider.notifier).getLastPortfolio();
      Period delta = ref.watch(activePortfolioProvider(portfolio)).period;
      // print(portfolio.steps.last.)
      return Stack(
        alignment: Alignment.center,
        children: [
          CentralButtonWidget(
            onLongPress: onLongPress,
            onTap: widget.onTap,
            getRadius: (double r) =>
                Future.microtask(() => setState(() => radius = r * 2)),
            satellites: widget.satellites,
            onSuccess: (p) {},
            initIndex: delta.index,
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
                  text: delta.name,
                  size: isBlur ? maxWidth : radius,
                  onTap: widget.onTap,
                  onLongPress: onLongPress,
                  isBlur: isBlur,
                  onSuccess: (Period period) {
                    setState(() => isBlur = !isBlur);
                    ref
                        .read(activePortfolioProvider(portfolio).notifier)
                        .updatePeriod(period);
                  },
                  initIndex: delta.index,
                )
              : const SizedBox(),
        ],
      );
    });
  }
}
