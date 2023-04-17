import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:time_machine/core/operations.dart';
import 'package:time_machine/data/models/portfolio.dart';
import 'package:time_machine/ui/widgets/central_button/blur_central_button_widget.dart';
import 'package:time_machine/ui/widgets/graph_cost/card_general_cost_widget.dart';
import 'package:time_machine/ui/widgets/ticker_logo_circle.dart';
import 'package:time_machine/ui/widgets/trading/stock_circle_preview.dart';

class TradingPage extends ConsumerWidget {
  const TradingPage({Key? key}) : super(key: key);

  void onTap() => ({});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final id = ModalRoute.of(context)!.settings.arguments as int;
    Portfolio activePortfolio =
        ref.watch(userPortfolioProvider.notifier).getPortfolio(id);
    List<List<double>> graphData =
        ref.watch(portfolioGraphDataProvider(activePortfolio));

    var satellites = [
      for (var stock in activePortfolio.steps.last.stocks.keys)
        StockCirclePreview(
            count: activePortfolio.steps.last.stocks[stock]!,
            onPressed: () {
              //TODO bottom sheet
            },
            child: TickerLogoCircle(ticker: stock.ticker))
    ];

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
                data: graphData,
              ),
            ),
            Flexible(
              flex: 9,
              fit: FlexFit.tight,
              child: BlurCentralButtonWidget(
                satellites: satellites,
                onTap: onTap,
              ),
            )
          ],
        ),
      ),
    );
  }
}
