import 'dart:math';

import 'package:flutter/material.dart';
import 'package:time_machine/ui/widgets/graph_cost/card_general_cost_widget.dart';

class CardGeneralCostExampleWidget extends StatelessWidget {
  const CardGeneralCostExampleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: CardGeneralCostWidget(
        data: [
          for (int i = 0; i < 40; i++)
            [
              i * 2.toDouble(),
              sin(i * 2) * i * 2,
            ],
        ],
        costStocks: "\$7,273,291",
        costCache: "\$193,28",
        delta: -2.41,
      ),
    );
  }
}
