import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:time_machine/core/model/portfolio_state.dart';
import 'package:time_machine/core/operations.dart';
import 'package:time_machine/data/models/portfolio.dart';
import 'package:time_machine/ui/widgets/central_button/blur_central_button_widget.dart';
import 'package:time_machine/ui/widgets/graph_cost/card_general_cost_widget.dart';
import 'package:time_machine/ui/widgets/ticker_logo_circle.dart';
import 'package:time_machine/ui/widgets/trading/stock_circle_preview.dart';

class TradingPage extends ConsumerWidget {
  const TradingPage({Key? key}) : super(key: key);

  void onTap(){}

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final id = ModalRoute.of(context)!.settings.arguments as int;
    Portfolio activePortfolio =
        ref.watch(userPortfolioProvider.notifier).getPortfolio(id);

    List<List<double>> graphData =
        ref.watch(portfolioGraphDataProvider(activePortfolio));

    PortfolioState portfolioState =
        ref.watch(activePortfolioProvider(activePortfolio));

    var currentStep = portfolioState.currentStep;

    var satellites = [
      for (var stock in activePortfolio.steps.last.stocks.keys)
        StockCirclePreview(
            count: currentStep.stocks[stock]!,
            onPressed: () {
              ref
                  .read(activePortfolioProvider(activePortfolio).notifier)
                  .addStock(stock, 1);
              ref
                  .read(activePortfolioProvider(activePortfolio).notifier)
                  .updateBalanceAndTotalValue();
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
                delta: ref
                    .read(activePortfolioProvider(activePortfolio).notifier)
                    .getGrowth(50)
                    .toStringAsFixed(1),
                costStocks:
                    portfolioState.portfolio.totalValue.toStringAsFixed(2),
                costCache: portfolioState.portfolio.balance.toStringAsFixed(2),
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
            ),
            Flexible(
              flex: 3,
                child:
                ElevatedButton(
                  onPressed: () {
                    //TODO reanimate balance and total
                    ref.read(activePortfolioProvider(activePortfolio).notifier).goToFuture(7);
                    ref.read(activePortfolioProvider(activePortfolio).notifier).commit(currentStep);
                    ref.read(userPortfolioProvider.notifier).updatePortfolio(portfolioState.portfolio);
                  },
                  child: const Text('Press me'),
                )
            )
          ],
        ),
      ),
    );
  }
}
