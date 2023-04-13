/// Оповещает о несоответствии введённого числа спецификации числа в приложении
class NumberValidator {
  String? validate(String? input) {
    if (input == null || input.isEmpty) return 'Введите число';
    if (input.contains(RegExp(r'\D'))) {
      return 'Число должно содержать только цифры';
    }
    return null;
  }
}
