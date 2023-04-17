import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:time_machine/app.dart';
import 'package:time_machine/core/provider/stock_choose/stock_provider.dart';
import 'package:time_machine/ui/widgets/stock_choose/stock_list_view.dart';

final Logger logger = Logger("StockChoosePage");

class StockChoosePage extends StatelessWidget {
  const StockChoosePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer(
          builder: (context, ref, child) {
            var tickers = ref
                .watch(
                  stockChooseProvider.select((value) => value.keys),
                )
                .toList();
            return ref.watch(stockQuotesInfoProvider).when(
                  loading: () => const CircularProgressIndicator(),
                  data: (values) {
                    return StockListView(
                      tickers: tickers,
                      costs: values[0],
                      grows: values[1],
                    );
                  },
                  error: (err, stack) => Text('Error: $err'),
                );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushReplacementNamed(
          AppRoutes.tradingUrl,
        ),
        child: const Icon(Icons.access_alarms_outlined),
      ),
    );
  }
}
