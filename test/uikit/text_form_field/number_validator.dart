import 'package:flutter_test/flutter_test.dart';
import 'package:time_machine/uikit/text_form_field/number/number_validator.dart';

void main() {
  late NumberValidator validator;

  setUp(() => validator = NumberValidator());

  group('Невалидное число', () {
    test('Число должно содержать только цифры', () {
      final result = validator.validate('8 994 000 76 36');
      expect(result, 'Число должно содержать только цифры');
    });
    test('Число должно содержать хотя бы одну цифру', () {
      final result = validator.validate('');
      expect(result, 'Введите число');
    });
    test('Число должно содержать хотя бы одну цифру', () {
      final result = validator.validate(null);
      expect(result, 'Введите число');
    });
  });
}
