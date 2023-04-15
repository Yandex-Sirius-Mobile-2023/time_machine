import 'package:flutter/material.dart';
import 'package:time_machine/uikit/ui_colors.dart';

class InfoCardGeneralCostWidget extends StatelessWidget {
  const InfoCardGeneralCostWidget({
    super.key,
    required this.costStocks,
    required this.costCache,
    required this.delta,
  });

  final String costStocks;
  final String costCache;
  final double delta;

  @override
  Widget build(BuildContext context) {
    const double defaultPadding = 15;

    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Общая стоимость ценных бумаг",
            style: TextStyle(
              color: UIColors.gray,
              fontFamily: "Inter",
              fontSize: 16,
            ),
          ),
          const SizedBox(height: defaultPadding),
          Text(
            costStocks,
            style: const TextStyle(
              color: UIColors.white,
              fontFamily: "Inter",
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Осталось наличных денег",
                    style: TextStyle(
                      color: UIColors.gray,
                      fontFamily: "Inter",
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: defaultPadding),
                  Text(
                    costCache,
                    style: const TextStyle(
                      color: UIColors.white,
                      fontFamily: "Inter",
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                    vertical: defaultPadding / 4,
                    horizontal: defaultPadding / 2),
                decoration: BoxDecoration(
                  color: UIColors.white,
                  borderRadius: BorderRadius.circular(2 * defaultPadding),
                ),
                child: Row(
                  children: [
                    Icon(
                        delta < 0
                            ? Icons.keyboard_arrow_down_rounded
                            : Icons.keyboard_arrow_up_rounded,
                        color: delta < 0 ? UIColors.red : UIColors.green,
                        size: 25),
                    const SizedBox(width: defaultPadding / 2),
                    Text(
                      delta.abs().toString(),
                      style: TextStyle(
                        color: delta < 0 ? UIColors.red : UIColors.green,
                        fontFamily: "Inter",
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
