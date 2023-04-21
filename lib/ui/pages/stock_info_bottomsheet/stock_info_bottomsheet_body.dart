import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:time_machine/core/operations.dart';
import 'package:time_machine/data/models/stock.dart';
import 'package:time_machine/ui/widgets/graph_cost/graph_cost_widget.dart';
import 'package:time_machine/ui/widgets/ticker_logo_circle.dart';
import 'package:time_machine/uikit/themes/ui_colors.dart';
import 'package:time_machine/uikit/ui_consts.dart';
import 'package:time_machine/uikit/ui_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StockInfoBottomSheetBody extends ConsumerWidget {
  const StockInfoBottomSheetBody(
      {Key? key, required this.stock, required this.id})
      : super(key: key);

  final Stock stock;
  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var activePortfolio =
        ref.watch(userPortfolioProvider.notifier).getPortfolio(id);
    var comparison = ref
        .watch(activePortfolioProvider(activePortfolio).notifier)
        .getGrowthForStock(stock);
    final history = stock.quotesHistory;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        UIText(stock.ticker.getName()),
        UIText('\$${history[activePortfolio.steps.last.date]!}'),
        Container(
          decoration: BoxDecoration(
            borderRadius:
                const BorderRadius.all(Radius.circular(UIConsts.paddings)),
            color: comparison > 0 ? UIColors.growColor : UIColors.dropColor,
          ),
          child: UIText(
              '${comparison > 0 ? '▲' : '▼'} ${comparison.toStringAsFixed(2)}%'),
        ),
        Flexible(
          child: Consumer(
            builder: (context, ref, child) {
              return GraphCostWidget(
                data: ref
                    .watch(activePortfolioProvider(activePortfolio).notifier)
                    .getGraphDataForStock(stock),
                isSingleWidget: true,
              );
            },
          ),
        ),
        _buildStockCard(stock, context),
        const SizedBox(height: UIConsts.paddings),
      ],
    );
  }

  Widget _buildStockCard(Stock stock, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(UIConsts.paddings),
      child: Row(
        children: [
          SizedBox(
            height: 50,
            width: 50,
            child: TickerLogoCircle(
              ticker: stock.ticker,
            ),
          ),
          UIText(
            stock.ticker.getName(),
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const Spacer(),
          _buildStockCounter(),
        ],
      ),
    );
  }

  Widget _buildStockCounter() {
    return Consumer(
      builder: (context, ref, _) {
        var activePortfolio =
            ref.watch(userPortfolioProvider.notifier).getPortfolio(id);
        int countOfStock = ref
            .watch(activePortfolioProvider(activePortfolio))
            .currentStep
            .stocks[stock]!;
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {
                if (countOfStock < 1) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(AppLocalizations.of(context)!.lowStocks)));
                  return;
                }
                ref
                    .read(activePortfolioProvider(activePortfolio).notifier)
                    .addStock(stock, -1, ref);
              },
              icon: const Icon(
                Icons.remove_circle,
                color: UIColors.dropColor,
                size: 40,
              ),
            ),
            Text(
              countOfStock.toString(),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            IconButton(
              onPressed: () {
                ref
                    .read(activePortfolioProvider(activePortfolio).notifier)
                    .addStock(stock, 1, ref);
              },
              icon: const Icon(
                Icons.add_circle,
                color: UIColors.growColor,
                size: 40,
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
