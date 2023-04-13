import 'package:flutter_test/flutter_test.dart';
import 'package:time_machine/uikit/text_form_field/number/number_formatter.dart';

void main() {
  late NumberFormatter formatter;

  setUp(() => formatter = NumberFormatter());

  test('Пробелы слева и справа обрезаются', () {
    const word = 'Hello';
    final result = formatter.format(' $word ');
    expect(result, word);
  });
}
