import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:time_machine/data/models/stock.dart';
import 'package:time_machine/ui/widgets/graph_cost/graph_cost_widget.dart';
import 'package:time_machine/uikit/themes/ui_colors.dart';
import 'package:time_machine/uikit/ui_consts.dart';
import 'package:time_machine/uikit/ui_text.dart';

class StockInfoBottomSheetBody extends StatefulWidget {
  const StockInfoBottomSheetBody({
    Key? key,
    required this.stock,
    required this.boughtStockCount,
    required this.onStockCountChanged,
  }) : super(key: key);

  final Stock stock;
  final int boughtStockCount;
  final Function(int) onStockCountChanged;

  @override
  State<StockInfoBottomSheetBody> createState() =>
      _StockInfoBottomSheetBodyState();
}

class _StockInfoBottomSheetBodyState extends State<StockInfoBottomSheetBody> {
  final _countController = TextEditingController();
  late int _curCount = widget.boughtStockCount;

  @override
  Widget build(BuildContext context) {
    final history = widget.stock.quotesHistory;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        UIText(widget.stock.ticker.getName()),
        UIText('\$${history.entries.last.value}'),
        _buildLastComparison(history),
        _buildChart(history),
        const Spacer(),
        _buildStockCard(widget.stock, widget.boughtStockCount),
        const SizedBox(height: UIConsts.paddings),
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
          _buildStockCounter(boughtStockCount),
        ],
      ),
    );
  }

  Widget _buildStockCounter(int boughtStockCount) {
    _countController.text = '$_curCount';
    return Consumer(
      builder: (context, ref, _) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  _curCount = max(_curCount - 1, 0);
                });
                widget.onStockCountChanged(_curCount);
              },
              icon: const Icon(
                Icons.remove_circle,
                color: UIColors.dropColor,
              ),
            ),
            Text('$_curCount'),
            IconButton(
              onPressed: () {
                setState(() => _curCount += 1);
                widget.onStockCountChanged(_curCount);
              },
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
