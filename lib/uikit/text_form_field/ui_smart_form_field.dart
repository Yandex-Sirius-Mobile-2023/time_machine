import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UISmartFormField extends StatefulWidget {
  const UISmartFormField({
    super.key,
    required this.initialValue,
    required this.onChanged,
    required this.hintText,
    required this.validator,
    required this.formatter,
    required this.keyboardType,
  });

  final String? initialValue;
  final void Function(String?) onChanged;
  final String? hintText;
  final FormFieldValidator<String> validator;
  final String Function(String) formatter;
  final TextInputType keyboardType;

  @override
  State<UISmartFormField> createState() => _UISmartFormFieldState();
}

class _UISmartFormFieldState extends State<UISmartFormField> {
  final _formKey = GlobalKey<FormFieldState<String>>();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: _formKey,
      decoration: InputDecoration(hintText: widget.hintText),
      initialValue: widget.initialValue,
      validator: widget.validator,
      keyboardType: widget.keyboardType,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      inputFormatters: [_wrapWithSmartCursos(widget.formatter)],
      onChanged: (input) {
        if (_formKey.currentState!.isValid) {
          widget.onChanged(input);
        } else {
          widget.onChanged(null);
        }
      },
    );
  }

  TextInputFormatter _wrapWithSmartCursos(String Function(String) formatter) {
    return TextInputFormatter.withFunction(
      (_, value) {
        final formattedText = formatter(value.text);
        return TextEditingValue(
          text: formattedText,
          selection: TextSelection.collapsed(
            offset: min(value.selection.end, formattedText.length),
          ),
        );
      },
    );
  }
}
