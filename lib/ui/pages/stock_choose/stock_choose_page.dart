import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:time_machine/core/provider/stock_choose/stock_provider.dart';
import 'package:time_machine/ui/pages/stock_choose/stock_card.dart';

final Logger logger = Logger("StockChoosePage");

class StockChoosePage extends StatelessWidget {
  const StockChoosePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const _StockListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => logger.info("Presse button"),
        child: const Icon(Icons.access_alarms_outlined),
      ),
    );
  }
}

class _StockListView extends ConsumerWidget {
  const _StockListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var tickers = ref.watch(stockChooseProvider).keys;

    return ListView(
      padding: const EdgeInsets.all(16),
      clipBehavior: Clip.none,
      itemExtent: 128,
      children: tickers
          .map(
            (e) => StockCard(ticker: e),
          )
          .toList(),
    );
  }
}
