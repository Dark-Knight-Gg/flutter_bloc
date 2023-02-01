
import 'package:formz/formz.dart';

import '../common/check_email_password.dart';
enum UsernameValidationError { empty }

class Username extends FormzInput<String, UsernameValidationError> {
  const Username.pure() : super.pure('');
  const Username.dirty([super.value = '']) : super.dirty();

  @override
  UsernameValidationError? validator(String value) {
    if (value.isEmpty && checkEmail(value) == true) return UsernameValidationError.empty;
    return null;
  }
}