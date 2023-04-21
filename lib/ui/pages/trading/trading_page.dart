import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:time_machine/core/model/portfolio_state.dart';
import 'package:time_machine/core/operations.dart';
import 'package:time_machine/data/models/portfolio.dart';
import 'package:time_machine/ui/pages/stock_info_bottomsheet/stock_info_bottomsheet_body.dart';
import 'package:time_machine/ui/widgets/central_button/blur_central_button_widget.dart';
import 'package:time_machine/ui/widgets/graph_cost/card_general_cost_widget.dart';
import 'package:time_machine/ui/widgets/ticker_logo_circle.dart';
import 'package:time_machine/ui/widgets/trading/stock_circle_preview.dart';
import 'package:time_machine/uikit/bottomsheet/ui_bottom_sheet.dart';

class TradingPage extends ConsumerWidget {
  const TradingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final id = ModalRoute.of(context)!.settings.arguments as int;
    Portfolio activePortfolio =
        ref.watch(userPortfolioProvider.notifier).getPortfolio(id);
    List<List<double>> graphData = ref
        .watch(activePortfolioProvider(activePortfolio).notifier)
        .getGraphData();
    PortfolioState portfolioState =
        ref.watch(activePortfolioProvider(activePortfolio));

    void onTap() {
      ref.read(activePortfolioProvider(activePortfolio).notifier).goToFuture();
      ref
          .read(userPortfolioProvider.notifier)
          .updatePortfolio(portfolioState.portfolio);
    }

    var satellites = [
      for (var stock in activePortfolio.steps.last.stocks.keys)
        StockCirclePreview(
            count: portfolioState.currentStep.stocks[stock]!,
            onPressed: () {
              HapticFeedback.mediumImpact();
              showUIBottomSheet(
                  context: context,
                  content: StockInfoBottomSheetBody(id: id, stock: stock));
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
                    .getGrowth()
                    .toStringAsFixed(1),
                costStocks: ref
                    .read(activePortfolioProvider(activePortfolio).notifier)
                    .getTotal()
                    .toStringAsFixed(2),
                costCache: ref
                    .read(activePortfolioProvider(activePortfolio).notifier)
                    .getBalance()
                    .toStringAsFixed(2),
                data: graphData,
              ),
            ),
            Flexible(
              flex: 9,
              fit: FlexFit.tight,
              child: BlurCentralButtonWidget(
                satellites: satellites,
                onTap: onTap,
                onLongPress: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
