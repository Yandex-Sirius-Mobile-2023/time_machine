// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:time_machine/core/model/portfolio_state.dart';

import 'package:time_machine/ui/widgets/central_button/blured_text_central_button.dart';
import 'package:time_machine/uikit/themes/ui_colors.dart';
import 'package:time_machine/uikit/ui_consts.dart';

class CentralItemButtonWidget extends StatelessWidget {
  const CentralItemButtonWidget({
    Key? key,
    required this.text,
    this.size,
    required this.onTap,
    required this.onLongPress,
    required this.isBlur,
    required this.onSuccess,
    required this.initIndex,
  }) : super(key: key);

  final String text;
  final double? size;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  final bool isBlur;
  final Function(Period) onSuccess;
  final int initIndex;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () async {
        if (isBlur) {
          return;
        }
        HapticFeedback.heavyImpact();
        await Future.delayed(UIConsts.duration);
        await Future.delayed(UIConsts.duration);
        HapticFeedback.mediumImpact();
        onLongPress();
      },
      onTap: () {
        HapticFeedback.mediumImpact();
        onTap();
      },
      child: AnimatedContainer(
        duration: UIConsts.duration,
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: UIColors.cyanDark,
          shape: BoxShape.circle,
          border: Border.all(width: 7, color: UIColors.cyanBright),
        ),
        child: isBlur
            ? BluredTextCentralButton(
                maxSize: size ?? 0,
                onClose: onLongPress,
                onSuccess: onSuccess,
                initIndex: initIndex,
              )
            : _InitTextCentralButton(text: text),
      ),
    );
  }
}

class _InitTextCentralButton extends StatelessWidget {
  const _InitTextCentralButton({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    String textButton = AppLocalizations.of(context)!.touchOrHold;

    return Column(
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
                  color: UIColors.whiteBackground,
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
                color: UIColors.whiteBackground,
              ),
        ),
      ],
    );
  }
}
