import 'package:flutter/material.dart';
import 'package:time_machine/ui/widgets/graph_cost/card_general_cost_widget.dart';
import 'package:time_machine/ui/widgets/planetar_system.dart';
import 'package:time_machine/ui/widgets/trading/stock_circle_preview.dart';

class TradingPage extends StatelessWidget {
  const TradingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        child: Column(
          children: [
            const Flexible(
              flex: 5,
              fit: FlexFit.tight,
              child: CardGeneralCostWidget(
                delta: 12,
                costStocks: "132123",
                costCache: "123123",
                data: [
                  [1, 2],
                  [1, 100],
                ],
              ),
            ),
            Flexible(
              flex: 9,
              fit: FlexFit.tight,
              child: PlanetarSystem(
                centralWidget: const ColoredBox(color: Colors.white),
                satellites: List.generate(
                  8,
                  (_) => StockCirclePreview(
                    count: 12,
                    child: const ColoredBox(color: Colors.white),
                    onPressed: () {},
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
