import 'package:flutter/material.dart';

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

    const Color gray = Color.fromRGBO(215, 215, 215, 1);
    const Color backgroundPrice = Color.fromRGBO(215, 245, 245, 1);
    const Color green = Color.fromRGBO(15, 220, 120, 1);
    const Color red = Color.fromRGBO(240, 90, 80, 1);

    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Общая стоимость ценных бумаг",
            style: TextStyle(
              color: gray,
              fontFamily: "Inter",
              fontSize: 16,
            ),
          ),
          const SizedBox(height: defaultPadding),
          Text(
            costStocks,
            style: const TextStyle(
              color: Colors.white,
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
                      color: gray,
                      fontFamily: "Inter",
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: defaultPadding),
                  Text(
                    costCache,
                    style: const TextStyle(
                      color: Colors.white,
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
                  color: backgroundPrice,
                  borderRadius: BorderRadius.circular(2 * defaultPadding),
                ),
                child: Row(
                  children: [
                    Icon(
                        delta < 0
                            ? Icons.keyboard_arrow_down_rounded
                            : Icons.keyboard_arrow_up_rounded,
                        color: delta < 0 ? red : green,
                        size: 25),
                    const SizedBox(width: defaultPadding / 2),
                    Text(
                      delta.abs().toString(),
                      style: TextStyle(
                        color: delta < 0 ? red : green,
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