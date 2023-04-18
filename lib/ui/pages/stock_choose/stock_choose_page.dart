import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:time_machine/app.dart';
import 'package:time_machine/core/operations.dart';
import 'package:time_machine/core/provider/quotes_info/quotes_info_provider.dart';
import 'package:time_machine/core/provider/stock_choose/stock_provider.dart';
import 'package:time_machine/ui/widgets/stock_choose/stock_list_view.dart';

final Logger logger = Logger("StockChoosePage");

class StockChoosePage extends StatelessWidget {
  const StockChoosePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var navigator = Navigator.of(context);

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
                  data: (value) {
                    return StockListView(
                      tickers: tickers,
                      costs: value.costs,
                      grows: value.grows,
                    );
                  },
                  error: (err, stack) => Text('Error: $err'),
                );
          },
        ),
      ),
      floatingActionButton: Consumer(
        builder: (context, ref, child) {
          return FloatingActionButton(
            onPressed: () async {
              var tickers = ref.watch(stockChooseProvider.notifier).choosen;
              int id = await ref
                  .watch(userPortfolioProvider.notifier)
                  .createPortfolio(tickers);
              navigator.pushReplacementNamed(AppRoutes.tradingUrl, arguments: id);
            },
            child: const Icon(Icons.access_alarms_outlined),
          );
        },
      ),
    );
  }
}
