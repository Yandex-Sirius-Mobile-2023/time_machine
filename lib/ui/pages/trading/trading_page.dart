import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:time_machine/app.dart';
import 'package:time_machine/core/model/portfolio_state.dart';
import 'package:time_machine/core/operations.dart';
import 'package:time_machine/data/models/portfolio.dart';
import 'package:time_machine/ui/pages/stock_info_bottomsheet/stock_info_bottomsheet_body.dart';
import 'package:time_machine/ui/widgets/central_button/blur_central_button_widget.dart';
import 'package:time_machine/ui/widgets/graph_cost/card_general_cost_widget.dart';
import 'package:time_machine/ui/widgets/ticker_logo_circle.dart';
import 'package:time_machine/ui/widgets/trading/stock_circle_preview.dart';
import 'package:time_machine/uikit/bottomsheet/ui_bottom_sheet.dart';
import 'package:time_machine/uikit/themes/ui_colors.dart';

class TradingPage extends ConsumerWidget {
  const TradingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var navigator = Navigator.of(context);
    final id = ModalRoute.of(context)!.settings.arguments as int;
    Portfolio activePortfolio =
        ref.watch(userPortfolioProvider.notifier).getPortfolio(id);
    List<List<double>> graphData = ref
        .watch(activePortfolioProvider(activePortfolio).notifier)
        .getGraphData();
    PortfolioState portfolioState =
        ref.watch(activePortfolioProvider(activePortfolio));

    void onTap() {
      ref
          .read(activePortfolioProvider(activePortfolio).notifier)
          .goToFuture(ref);
      if (activePortfolio.endOfGame) {
        navigator.pushReplacementNamed(AppRoutes.finish, arguments: id);
      }
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
    final start = DateTime.parse("2012-01-03 00:00:00");
    final end = DateTime.parse("2022-12-30 00:00:00");

    final differenceInit = end.difference(start).inDays;
    final differenceEnd = portfolioState.now.difference(start).inDays;

    int step = differenceEnd * 100 ~/ differenceInit;

    const LinearGradient gradient = LinearGradient(
      colors: [
        UIColors.cyanDark,
        UIColors.cyanBright,
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        child: Stack(
          children: [
            Column(
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
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                  height: 20,
                  width: double.infinity,
                  child: Row(
                    children: [
                      Expanded(
                        flex: step,
                        child: Container(
                          decoration: BoxDecoration(
                              gradient: gradient,
                              borderRadius: BorderRadius.circular(1000)),
                        ),
                      ),
                      Expanded(
                        flex: 100 - step,
                        child: const SizedBox(),
                      )
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
