import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:time_machine/uikit/text_form_field/number/number_formatter.dart';
import 'package:time_machine/uikit/text_form_field/number/number_validator.dart';

final numberValidatorProvider = StateProvider((ref) => NumberValidator());
final numberFormatterProvider = StateProvider((ref) => NumberFormatter());
