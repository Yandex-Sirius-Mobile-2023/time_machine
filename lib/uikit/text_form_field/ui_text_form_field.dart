import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../injection.dart';
import 'ui_smart_form_field.dart';

class UITextFormField extends ConsumerWidget {
  /// Поле, реализующее спецификацию к текстовому формату чисел.
  const UITextFormField.number({
    super.key,
    this.initialValue,
    required this.onChanged,
    this.hintText,
  }) : _inputType = _InputType.number;

  // Риверпод форсирует получение зависимостей в билде.
  // Эта переменная доносит необходимый тип от конструктора до билда.
  final _InputType _inputType;

  /// Первоначальное значение поля.
  final String? initialValue;

  /// Если значение валидно, отправляет отформатированное значение обратно.
  /// Если значение невалидно, отправляет назад [null]
  final void Function(String?) onChanged;

  /// Подсказка, отображающаяся в созданном поле. Подсказка пропадает при
  /// введении пользователем числа.
  final String? hintText;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    late final FormFieldValidator<String> validator;
    late final String Function(String) formatter;
    late final TextInputType keyboardType;

    switch (_inputType) {
      case _InputType.number:
        validator = ref.read(numberValidatorProvider).validate;
        formatter = ref.read(numberFormatterProvider).format;
        keyboardType = TextInputType.number;
    }

    return UISmartFormField(
      initialValue: '$initialValue',
      hintText: hintText,
      keyboardType: keyboardType,
      validator: validator,
      formatter: formatter,
      onChanged: onChanged,
    );
  }
}

enum _InputType {
  number,
}
