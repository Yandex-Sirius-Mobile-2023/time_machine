import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:time_machine/data/models/stock.dart';

import 'stock_card.dart';

class StockListView extends ConsumerWidget {
  final List<StockTicker> tickers;
  const StockListView({
    super.key,
    required this.tickers,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      clipBehavior: Clip.none,
      itemExtent: 128,
      itemCount: tickers.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: StockCard(
          ticker: tickers[index],
          grow: 34,
          cost: 2136.23,
        ),
      ),
    );
  }
}
