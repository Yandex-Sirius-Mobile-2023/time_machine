import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:time_machine/core/operations.dart';
import 'package:time_machine/core/provider/image_provider.dart';
import 'package:time_machine/data/models/portfolio.dart';
import 'package:time_machine/ui/widgets/graph_cost/card_general_cost_widget.dart';
import 'package:time_machine/ui/widgets/planetar_system.dart';
import 'package:time_machine/ui/widgets/trading/stock_circle_preview.dart';

class TradingPage extends ConsumerWidget {
  const TradingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref ){

    final id = ModalRoute.of(context)!.settings.arguments as int;
    Portfolio activePortfolio = ref.watch(userPortfolioProvider.notifier).getPortfolio(id);
    return Scaffold(
        body: SafeArea(
      minimum: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Column(
        children: [
          Flexible(
            flex: 5,
            fit: FlexFit.tight,
            child: CardGeneralCostWidget(
              delta: 12,
              costStocks: activePortfolio.totalValue.toString(),
              costCache: activePortfolio.balance.toString(),
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
                  satellites: [
                    for (var stock in activePortfolio.steps.last.stocks.keys)
                      StockCirclePreview(
                        count: activePortfolio.steps.last.stocks[stock]!,
                        onPressed: () {
                          //TODO bottom sheet
                        },
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(32),
                            child: Consumer(builder: (context, ref, child) {
                              return ref.watch(stockImageProvider(stock.ticker)).when(
                                  data: (imageurl) => ClipRRect(
                                        borderRadius: BorderRadius.circular(32),
                                        child: SvgPicture.network(imageurl),
                                      ),
                                  error: (err, stack) => Text('Error: $err'),
                                  loading: () =>
                                      const CircularProgressIndicator());
                            })),
                      ),
                  ],
                ))])
    ));
  }
}

