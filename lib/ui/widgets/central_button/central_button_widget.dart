import 'package:flutter/material.dart';
import 'package:time_machine/ui/widgets/planetar_system.dart';
import 'package:time_machine/uikit/ui_colors.dart';
import 'package:time_machine/uikit/ui_consts.dart';

class CentralButtonWidget extends StatelessWidget {
  const CentralButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    String text = "7 дн";
    String textButton = "Нажми /\nудерживай";

    return PlanetarSystem(
      innerSpacing: 20,
      satellitesSpacing: 30,
      satellites: [
        Image.asset("assets/images/ali.png"),
        Image.asset("assets/images/microsoft.png"),
        Image.asset("assets/images/amazon.png"),
        Image.asset("assets/images/apple.png"),
        Image.asset("assets/images/mac.png"),
        Image.asset("assets/images/tesla.png"),
        Image.asset("assets/images/toyota.png"),
        Image.asset("assets/images/yandex.png"),
      ],
      centralWidget: Container(
        decoration: BoxDecoration(
          color: UIColors.cyanDark,
          shape: BoxShape.circle,
          border: Border.all(width: 7, color: UIColors.cyanBright),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: UIColors.cyanBright,
                borderRadius: BorderRadius.circular(100),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: UIConsts.paddings / 2,
                vertical: UIConsts.paddings / 4,
              ),
              child: Text(
                text,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: UIColors.white,
                    ),
              ),
            ),
            const SizedBox(height: UIConsts.paddings),
            Container(
              width: UIConsts.doublePaddings,
              height: UIConsts.doublePaddings,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 3,
                  color: UIColors.cyanBright,
                ),
              ),
              child: Center(
                child: Container(
                  width: 9,
                  height: 9,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: UIColors.cyanBright,
                  ),
                ),
              ),
            ),
            const SizedBox(height: UIConsts.paddings),
            Text(
              textButton,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: UIColors.white,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
