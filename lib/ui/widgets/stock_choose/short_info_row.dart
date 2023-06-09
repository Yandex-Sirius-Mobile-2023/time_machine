import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:time_machine/core/provider/stock_choose/stock_provider.dart';
import 'package:time_machine/data/models/stock.dart';
import 'package:time_machine/ui/widgets/ticker_logo_circle.dart';
import 'package:time_machine/uikit/themes/ui_colors.dart';
import 'package:time_machine/uikit/ui_consts.dart';

/// Widget that displays name, icon and choose button.
class ShortInfoRow extends StatelessWidget {
  final StockTicker ticker;
  const ShortInfoRow({super.key, required this.ticker});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TickerLogoCircle(ticker: ticker),
        const SizedBox(width: 12),
        _StockNameHeader(ticker: ticker),
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: _StockChooseButton(ticker: ticker),
          ),
        ),
      ],
    );
  }
}

/// Button to choose ticker in.
class _StockChooseButton extends ConsumerWidget {
  const _StockChooseButton({
    required this.ticker,
  });

  final StockTicker ticker;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        ref.read(stockChooseProvider.notifier).updateTicker(ticker);
      },
      child: AnimatedContainer(
        duration: UIConsts.duration,
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: ref.watch(stockChooseProvider)[ticker]!
              ? UIColors.growColor
              : UIColors.dropColor,
        ),
        child: ref.watch(stockChooseProvider)[ticker]!
            ? const Icon(Icons.check)
            : const Icon(Icons.add_rounded),
      ),
    );
  }
}

/// Widget that displays stock ticker name and full name.
class _StockNameHeader extends StatelessWidget {
  final StockTicker ticker;

  const _StockNameHeader({required this.ticker});

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
