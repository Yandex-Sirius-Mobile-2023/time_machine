import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  static const double padding = 8;

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
        _buildLastComparison(history, context, comparison),
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

  Widget _buildLastComparison(
      Map<DateTime, double> history, BuildContext context, double comprasion) {
    var colorScheme = Theme.of(context).colorScheme;
    final last = history.values.fromEnd(0);
    final preLast = history.values.fromEnd(1);

    //TODO: Вставить риск.
    final risk = 0.55;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(UIConsts.paddings),
              ),
              color: colorScheme.surface,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(2, 2),
                  blurRadius: 8,
                ),
              ]),
          child: Padding(
            padding: const EdgeInsets.all(padding),
            child: Row(
              children: [
                SizedBox(
                  height: 16,
                  width: 16,
                  child: ClipOval(
                    child: ColoredBox(color: getRiskColor(risk)),
                  ),
                ),
                const SizedBox(width: padding),
                Text(
                  risk.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: padding * 2),
        Container(
          decoration: BoxDecoration(
            borderRadius:
                const BorderRadius.all(Radius.circular(UIConsts.paddings)),
            color: comprasion > 0 ? UIColors.growColor : UIColors.dropColor,
          ),
          child: UIText(
              '${comprasion > 0 ? '▲' : '▼'} ${comprasion.toStringAsFixed(2)}%'),
        ),
      ],
    );
  }

  Color getRiskColor(double risk) {
    if (risk > .5) {
      return UIColors.redAccent;
    } else if (risk > .2) {
      return Colors.yellow;
    } else {
      return UIColors.growColor;
    }
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
          const SizedBox(width: padding),
          Expanded(
            child: Text(
              stock.ticker.getName(),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              textAlign: TextAlign.justify,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontSize: 20),
            ),
          ),
          const SizedBox(width: padding),
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
                HapticFeedback.lightImpact();
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
                HapticFeedback.lightImpact();
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
