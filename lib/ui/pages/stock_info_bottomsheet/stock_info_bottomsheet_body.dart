import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:time_machine/data/models/stock.dart';
import 'package:time_machine/ui/pages/stock_info_bottomsheet/stock_info_manager.dart';
import 'package:time_machine/ui/pages/stock_info_bottomsheet/stock_info_state.dart';
import 'package:time_machine/ui/widgets/graph_cost/graph_cost_widget.dart';
import 'package:time_machine/uikit/themes/ui_colors.dart';
import 'package:time_machine/uikit/ui_consts.dart';
import 'package:time_machine/uikit/ui_text.dart';

class StockInfoBottomSheetBody extends ConsumerStatefulWidget {
  const StockInfoBottomSheetBody({
    Key? key,
    required this.ticker,
  }) : super(key: key);

  final StockTicker ticker;

  @override
  ConsumerState createState() => _StockInfoBottomSheetBodyState();
}

class _StockInfoBottomSheetBodyState
    extends ConsumerState<StockInfoBottomSheetBody> {
  final _countController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(stockInfoProvider.notifier).loadStocks(widget.ticker);
    });
  }

  @override
  void didUpdateWidget(covariant StockInfoBottomSheetBody oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.ticker != widget.ticker) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(stockInfoProvider.notifier).loadStocks(widget.ticker);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(stockInfoProvider);
    return state.map(
      loading: _buildStateLoading,
      content: _buildStateContent,
    );
  }

  Widget _buildStateLoading(StockInfoStateLoading state) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildStateContent(StockInfoStateContent state) {
    final stock = state.stock;
    final history = stock.quotesHistory;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        UIText(stock.ticker.getName()),
        UIText('\$${history.entries.last.value}'),
        _buildLastComparison(history),
        _buildChart(history),
        _buildStockCard(stock, state.boughtStockCount),
      ],
    );
  }

  Widget _buildLastComparison(Map<DateTime, double> history) {
    final last = history.values.fromEnd(0);
    final preLast = history.values.fromEnd(1);
    final comparison = last / preLast;

    return Container(
      decoration: BoxDecoration(
        borderRadius:
            const BorderRadius.all(Radius.circular(UIConsts.paddings)),
        color: comparison > 0 ? UIColors.growColor : UIColors.dropColor,
      ),
      child: UIText(
          '${comparison > 0 ? '▲' : '▼'} ${comparison.toStringAsFixed(2)}%'),
    );
  }

  Widget _buildChart(Map<DateTime, double> history) {
    final dataForChart = history.entries
        .map((entry) =>
            [entry.key.millisecondsSinceEpoch.toDouble(), entry.value])
        .toList();
    return SizedBox(
      height: 200,
      child: GraphCostWidget(
        data: dataForChart,
        isSingleWidget: true,
      ),
    );
  }

  Widget _buildStockCard(Stock stock, int boughtStockCount) {
    return Container(
      padding: const EdgeInsets.all(UIConsts.paddings),
      color: UIColors.whiteBackground,
      child: Row(
        children: [
          Container(
            color: UIColors.dropColor,
            height: 50,
            width: 50,
          ),
          UIText(stock.ticker.getName()),
          const Spacer(),
          Flexible(child: _buildStockCounter(boughtStockCount)),
        ],
      ),
    );
  }

  Widget _buildStockCounter(int boughtStockCount) {
    _countController.text = '$boughtStockCount';
    return Consumer(
      builder: (context, ref, _) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: ref.watch(stockInfoProvider.notifier).decrementStock,
              icon: const Icon(
                Icons.remove_circle,
                color: UIColors.dropColor,
              ),
            ),
            Flexible(
              child: TextFormField(
                controller: _countController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                onSaved: (input) => ref
                    .watch(stockInfoProvider.notifier)
                    .setStockCount(int.parse(input!)),
              ),
            ),
            IconButton(
              onPressed: ref.watch(stockInfoProvider.notifier).incrementStock,
              icon: const Icon(
                Icons.add_circle,
                color: UIColors.growColor,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _countController.dispose();
    super.dispose();
  }
}

extension IterableExtension<T> on Iterable<T> {
  T fromEnd(int i) {
    return toList().reversed.toList()[i];
  }
}
