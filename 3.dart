import 'dart:io';

class PasswordValidator {
  static const int minLength = 8;
  static bool _hasDigit(String password) {
    return password.contains(RegExp(r'[0-9]'));
  }

  static bool validate(String? password) {
    if (password == null || password.isEmpty) return false;
    if (password.length < minLength) return false;
    if (!_hasDigit(password)) return false;
    return true;
  }
}

void main() {
  stdout.write('Введите пароль для проверки: ');
  String? input = stdin.readLineSync();
  bool isValid = PasswordValidator.validate(input);
  print('\nРезультат проверки:');
  print('Пароль: "${input ?? ''}"');
  print(
    'Требования: минимум ${PasswordValidator.minLength} символов, хотя бы одна цифра.',
  );
  print(
    'Статус: ${isValid ? '✓ Пароль надёжный' : '✗ Пароль не соответствует требованиям'}',
  );
}
