import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:time_machine/core/provider/stock_choose/stock_provider.dart';

import '../../../data/models/stock.dart';

class StockCard extends ConsumerWidget {
  final StockTicker ticker;
  const StockCard({super.key, required this.ticker});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      elevation: 0,
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
                const CircleAvatar(
                  backgroundColor: Colors.red,
                ),
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
            _CostRow(),
          ],
        ),
      ),
    );
  }
}

class _CostRow extends StatelessWidget {
  const _CostRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            r"$0.99",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            r"+132",
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.lightGreen),
          ),
        ),
      ],
    );
  }
}

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
        duration: const Duration(milliseconds: 300),
        color: ref.watch(stockChooseProvider)[ticker]! ? Colors.green : Colors.blue,
        child: const SizedBox(
          height: 32,
          width: 32,
        ),
      ),
    );
  }
}

// Widget that displays stock ticker and full name.
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
