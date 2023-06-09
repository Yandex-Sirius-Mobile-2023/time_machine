import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:time_machine/app.dart';
import 'package:time_machine/core/operations.dart';
import 'package:time_machine/core/provider/quotes_info/quotes_info_provider.dart';
import 'package:time_machine/core/provider/stock_choose/stock_provider.dart';
import 'package:time_machine/ui/widgets/stock_choose/stock_list_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
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
          return FilledButton(
            onPressed: () async {
              HapticFeedback.mediumImpact();
              var tickers = ref.watch(stockChooseProvider.notifier).choosen;
              if (tickers.length < 2) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(AppLocalizations.of(context)!.lowStocks)));
                return;
              }
              int id = await ref
                  .watch(userPortfolioProvider.notifier)
                  .createPortfolio(tickers);
              navigator.pushReplacementNamed(AppRoutes.tradingUrl,
                  arguments: id);
            },
            child: Text(AppLocalizations.of(context)!.save),
          );
        },
      ),
    );
  }
}
