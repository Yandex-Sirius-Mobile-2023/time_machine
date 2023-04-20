// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:time_machine/core/model/portfolio_state.dart';

import 'package:time_machine/uikit/themes/ui_colors.dart';
import 'package:time_machine/uikit/ui_consts.dart';

import 'blured_time_picker_button.dart';

class BluredTextCentralButton extends StatelessWidget {
  final double maxSize;
  final VoidCallback onClose;
  final Function(Period) onSuccess;
  final int initIndex;

  const BluredTextCentralButton({
    Key? key,
    required this.maxSize,
    required this.onClose,
    required this.onSuccess,
    required this.initIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClose,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: Container(
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
          ),
          BluredTimePickerButton(
            maxSize: maxSize,
            onSuccess: onSuccess,
            initIndex: initIndex,
          )
        ],
      ),
    );
  }
}
