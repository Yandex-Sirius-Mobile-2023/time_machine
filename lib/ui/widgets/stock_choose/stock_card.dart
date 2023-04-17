import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:time_machine/core/provider/stock_choose/stock_provider.dart';
import 'package:time_machine/data/models/stock.dart';

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
          vertical: 8,
          horizontal: 32,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                Consumer(builder: (context, ref, child) {
                  return ref.watch(stockImageProvider).when(
                      data: (images) => ClipRRect(
                            borderRadius: BorderRadius.circular(32),
                            child: SvgPicture.network(images[ticker]!),
                          ),
                      error: (err, stack) => Text('Error: $err'),
                      loading: () => const CircularProgressIndicator());
                }),
                const SizedBox(width: 16),
                _StockNameHeader(ticker: ticker),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: _StockChooseButton(ticker: ticker),
                  ),
                ),
              ],
            ),
            _CostRow(
              grow: grow,
              cost: cost,
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
  IconData get growIcon =>
      grow > 0 ? Icons.arrow_drop_up : Icons.arrow_drop_down;

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

// Button to choose ticker in.
class _StockChooseButton extends ConsumerWidget {
  const _StockChooseButton({
    super.key,
    required this.ticker,
  });

  final StockTicker ticker;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        ref.read(stockChooseProvider.notifier).updateTicker(ticker);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: ref.watch(stockChooseProvider)[ticker]!
              ? Colors.green
              : Colors.blue,
        ),
        child: Icon(Icons.keyboard_double_arrow_right_sharp),
      ),
    );
  }
}

// Widget that displays stock ticker name and full name.
class _StockNameHeader extends StatelessWidget {
  final StockTicker ticker;

  const _StockNameHeader({super.key, required this.ticker});

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            ticker.name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            ticker.getName(),
          ),
        ],
      ),
    );
  }
}
