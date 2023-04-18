import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:time_machine/data/models/stock.dart';

import 'stock_card.dart';

class StockListView extends ConsumerWidget {
  final List<StockTicker> tickers;
  final List<double> costs;
  final List<double> grows;
  const StockListView({
    super.key,
    required this.tickers,
    required this.costs,
    required this.grows,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      clipBehavior: Clip.none,
      itemExtent: 132,
      itemCount: tickers.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: StockCard(
          ticker: tickers[index],
          grow: grows[index],
          cost: costs[index],
        ),
      ),
    );
  }
}
