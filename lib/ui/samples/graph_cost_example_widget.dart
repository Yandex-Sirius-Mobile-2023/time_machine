import 'dart:math';

import 'package:flutter/material.dart';
import 'package:time_machine/ui/widgets/graph_cost/graph_cost_widget.dart';

class GraphCostExampleWidget extends StatelessWidget {
  const GraphCostExampleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: GraphCostWidget(
        data: [
          for (int i = 0; i < 40; i++)
            [
              i * 2.toDouble(),
              sin(i * 2) * i * 2,
            ],
        ],
        isSingleWidget: true,
      ),
    );
  }
}
