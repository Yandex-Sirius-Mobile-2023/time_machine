import 'package:flutter/material.dart';
import 'package:time_machine/uikit/ui_colors.dart';

import 'graph_cost_widget.dart';
import 'info_card_general_cost_widget.dart';

class CardGraphCostWidget extends StatelessWidget {
  const CardGraphCostWidget({
    super.key,
    required this.data,
    required this.costStocks,
    required this.costCache,
    required this.delta,
  });

  final List<List<double>> data;
  final String costStocks;
  final String costCache;
  final double delta;

  @override
  Widget build(BuildContext context) {
    const LinearGradient gradient = LinearGradient(
      colors: [
        UIColors.cyanDark,
        UIColors.cyanBright,
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    const double defaultPadding = 15;

    return Padding(
      padding: const EdgeInsets.only(bottom: defaultPadding),
      child: Container(
        height: 250,
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(defaultPadding),
        ),
        child: Stack(
          children: [
            GraphCostWidget(data: data, isSingleWidget: false),
            InfoCardGeneralCostWidget(
              costStocks: costStocks,
              costCache: costCache,
              delta: delta,
            ),
          ],
        ),
      ),
    );
  }
}
