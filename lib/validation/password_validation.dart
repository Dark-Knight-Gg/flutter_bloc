import 'package:formz/formz.dart';

import '../common/check_email_password.dart';

enum PasswordValidationError { empty }

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure() : super.pure('');
  const Password.dirty([super.value = '']) : super.dirty();

  @override
  PasswordValidationError? validator(String value) {
    if (value.isEmpty && checkPassword(value)==true) return PasswordValidationError.empty;
    return null;
  }
}