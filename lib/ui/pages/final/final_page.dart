import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:time_machine/app.dart';
import 'package:time_machine/core/operations.dart';
import 'package:time_machine/ui/widgets/graph_cost/graph_cost_widget.dart';
import 'package:time_machine/uikit/themes/ui_colors.dart';
import 'package:time_machine/uikit/ui_consts.dart';
import 'package:time_machine/uikit/ui_text.dart';

class FinalPage extends ConsumerWidget {
  const FinalPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (_, constrains) => Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: UIConsts.paddings),
          child: ConstrainedBox(
            constraints: const BoxConstraints.expand(
              width: double.infinity,
              height: 50,
            ),
            child: FloatingActionButton.extended(
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(AppRoutes.profileUrl);
              },
              backgroundColor: UIColors.cyanBright,
              label: const Text('Return to main screen'),
            ),
          ),
        ),
        body: _buildContent(context),
      ),
    );
  }

  Column _buildContent(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(UIConsts.doublePaddings),
          child: UIText(
            'FINISH',
            style: Theme.of(context).textTheme.titleLarge!.apply(
                  color: UIColors.cyanBright,
                  fontSizeFactor: 1.5,
                ),
          ),
        ),
        const Flexible(child: _TotalCostCard()),
        const Flexible(
          child: GraphCostWidget(
            //TODO сюда данные для графика бота
            data: [
              [1, 4],
              [2, 6],
              [3, 2],
            ],
            isSingleWidget: true,
          ),
        ),
        const Text('Bot cost'),
        const SizedBox(height: 16),
        const Flexible(
          child: GraphCostWidget(
            //TODO сюда данные для графика игрока
            data: [
              [1, 4],
              [2, 2],
              [3, 3],
            ],
            isSingleWidget: true,
          ),
        ),
        const Text('Gamer cost'),
      ],
    );
  }
}

class _TotalCostCard extends ConsumerWidget {
  const _TotalCostCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int id = ModalRoute.of(context)!.settings.arguments as int;
    var portfolio = ref.read(userPortfolioProvider.notifier).getPortfolio(id);
    var portfolioNotifier =
        ref.read(activePortfolioProvider(portfolio).notifier);
    const LinearGradient gradient = LinearGradient(
      colors: [
        UIColors.cyanDark,
        UIColors.cyanBright,
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    final finalCost =
        portfolioNotifier.getBalance() + portfolioNotifier.getTotal();
    const startCost = 1000000.0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: UIConsts.paddings),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(UIConsts.paddings),
          decoration: const BoxDecoration(gradient: gradient),
          child: Row(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UIText(
                    'Start cost:   \$ $startCost',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .apply(color: Colors.white70),
                  ),
                  UIText(
                    'Final cost:   \$ ${finalCost.toStringAsFixed(2)}',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .apply(color: Colors.white70),
                  ),
                ],
              ),
              const Spacer(),
              _buildComparison(startCost, finalCost),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildComparison(double startVal, double finalVal) {
    final comparison = finalVal / startVal;

    return Container(
      decoration: BoxDecoration(
        borderRadius:
            const BorderRadius.all(Radius.circular(UIConsts.paddings)),
        color: comparison > 1 ? UIColors.growColor : UIColors.dropColor,
      ),
      child: Row(
        children: [
          const SizedBox(width: 8),
          Icon(comparison > 1
              ? Icons.keyboard_arrow_down_rounded
              : Icons.keyboard_arrow_up_rounded),
          UIText(' ${comparison.toStringAsFixed(2)}%'),
        ],
      ),
    );
  }
}
