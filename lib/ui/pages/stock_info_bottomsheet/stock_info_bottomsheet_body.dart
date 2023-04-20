import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:time_machine/core/operations.dart';
import 'package:time_machine/data/models/portfolio.dart';
import 'package:time_machine/data/models/stock.dart';
import 'package:time_machine/ui/widgets/graph_cost/graph_cost_widget.dart';
import 'package:time_machine/ui/widgets/ticker_logo_circle.dart';
import 'package:time_machine/uikit/themes/ui_colors.dart';
import 'package:time_machine/uikit/ui_consts.dart';
import 'package:time_machine/uikit/ui_text.dart';

class StockInfoBottomSheetBody extends ConsumerWidget {
  const StockInfoBottomSheetBody({
    Key? key,
    required this.stock,
    required this.id
  }) : super(key: key);

  final Stock stock;
  final int id;

  Widget build(BuildContext context, WidgetRef ref) {
    final history = stock.quotesHistory;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        UIText(stock.ticker.getName()),
        UIText('\$${history.entries.last.value}'),
        _buildLastComparison(history),
        Flexible(child: _buildChart(history)),
        _buildStockCard(stock),
        const SizedBox(height: UIConsts.paddings),
      ],
    );
  }

  Widget _buildLastComparison(Map<DateTime, double> history) {
    final last = history.values.fromEnd(0);
    final preLast = history.values.fromEnd(1);
    final comparison = last / preLast;

    return Container(
      decoration: BoxDecoration(
        borderRadius:
            const BorderRadius.all(Radius.circular(UIConsts.paddings)),
        color: comparison > 0 ? UIColors.growColor : UIColors.dropColor,
      ),
      child: UIText(
          '${comparison > 0 ? '▲' : '▼'} ${comparison.toStringAsFixed(2)}%'),
    );
  }

  Widget _buildChart(Map<DateTime, double> history) {
    final dataForChart = history.entries
        .map((entry) =>
            [entry.key.millisecondsSinceEpoch.toDouble(), entry.value])
        .toList();
    return GraphCostWidget(
      data: dataForChart,
      isSingleWidget: true,
    );
  }

  Widget _buildStockCard(Stock stock) {
    return Container(
      padding: const EdgeInsets.all(UIConsts.paddings),
      color: UIColors.whiteBackground,
      child: Row(
        children: [
          Expanded(
            child: TickerLogoCircle(
              ticker: stock.ticker,
            ),
          ),
          UIText(stock.ticker.getName()),
          const Spacer(),
          _buildStockCounter(),
        ],
      ),
    );
  }

  Widget _buildStockCounter() {
    return Consumer(
      builder: (context, ref, _) {
        var activePortfolio = ref.watch(userPortfolioProvider.notifier).getPortfolio(id);
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {
                ref
                    .read(activePortfolioProvider(activePortfolio).notifier)
                    .addStock(stock, -1, ref);
              },
              icon: const Icon(
                Icons.remove_circle,
                color: UIColors.dropColor,
              ),
            ),
            Text(ref
                .watch(activePortfolioProvider(activePortfolio))
                .currentStep
                .stocks[stock]
                .toString()),
            IconButton(
              onPressed: () {
                ref
                    .read(activePortfolioProvider(activePortfolio).notifier)
                    .addStock(stock, 1,ref);
              },
              icon: const Icon(
                Icons.add_circle,
                color: UIColors.growColor,
              ),
            ),
          ],
        );
      },
    );
  }
}

extension IterableExtension<T> on Iterable<T> {
  T fromEnd(int i) {
    return toList().reversed.toList()[i];
  }
}
