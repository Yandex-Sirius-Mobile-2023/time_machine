import 'package:flutter/material.dart';
import 'package:time_machine/uikit/themes/ui_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InfoCardGeneralCostWidget extends StatelessWidget {
  const InfoCardGeneralCostWidget({
    super.key,
    required this.costStocks,
    required this.costCache,
    required this.delta,
  });

  final String costStocks;
  final String costCache;
  final String delta;

  @override
  Widget build(BuildContext context) {
    const double defaultPadding = 15;

    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.totalCostStock,
            style: const TextStyle(
              color: UIColors.grey,
              fontFamily: "Inter",
              fontSize: 16,
            ),
          ),
          const SizedBox(height: defaultPadding),
          Text(
            costStocks,
            style: const TextStyle(
              color: UIColors.whiteBackground,
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
                  Text(
                    AppLocalizations.of(context)!.cacheLeft,
                    style: const TextStyle(
                      color: UIColors.grey,
                      fontFamily: "Inter",
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: defaultPadding),
                  Text(
                    costCache,
                    style: const TextStyle(
                      color: UIColors.whiteBackground,
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
                  color: UIColors.whiteBackground,
                  borderRadius: BorderRadius.circular(2 * defaultPadding),
                ),
                child: Row(
                  children: [
                    Icon(
                        double.parse(delta) < 0
                            ? Icons.keyboard_arrow_down_rounded
                            : Icons.keyboard_arrow_up_rounded,
                        color: double.parse(delta) < 0
                            ? UIColors.dropColor
                            : UIColors.growColor,
                        size: 25),
                    const SizedBox(width: defaultPadding / 2),
                    SizedBox(
                      width: 32,
                      child: Text(
                        delta,
                        style: TextStyle(
                          color: double.parse(delta) < 0
                              ? UIColors.dropColor
                              : UIColors.growColor,
                          fontFamily: "Inter",
                          fontSize: 16,
                        ),
                        maxLines: 1,
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
