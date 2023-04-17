import 'package:flutter/material.dart';
import 'package:time_machine/data/models/stock.dart';
import 'package:time_machine/ui/widgets/stock_choose/short_info_row.dart';

/// Card that represent a tickers that can be choosen.
class StockCard extends StatelessWidget {
  final StockTicker ticker;
  final double grow;
  final double cost;

  const StockCard({
    required this.grow,
    super.key,
    required this.ticker,
    required this.cost,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 32,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Flexible(
              flex: 2,
              child: ShortInfoRow(ticker: ticker),
            ),
            Flexible(
              flex: 1,
              child: _CostRow(
                grow: grow,
                cost: cost,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Row with cost and grow text
class _CostRow extends StatelessWidget {
  /// Grow from prev year.
  final double grow;
  final double cost;

  const _CostRow({
    super.key,
    required this.grow,
    required this.cost,
  });

  Color get growColor => grow > 0 ? Colors.greenAccent : Colors.redAccent;
  IconData get growIcon => grow > 0 ? Icons.arrow_drop_up : Icons.arrow_drop_down;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "\$${cost.toStringAsFixed(2)}",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: Icon(
              growIcon,
              color: growColor,
              size: 32,
            ),
          ),
        ),
        Text(
          "${grow.abs().toStringAsFixed(2)}%",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: growColor,
          ),
        ),
      ],
    );
  }
}
