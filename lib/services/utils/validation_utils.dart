import 'package:email_validator/email_validator.dart';

final class ValidationUtils {
  ValidationUtils._();

  static String? emailValidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter your email';
    } else if (EmailValidator.validate(value)) {
      return null;
    } else {
      return 'Enter valid email';
    }
  }

  static String? textNotEmptyValidation(String? value,
      {required String emptyMessage}) {
    if (value == null || value.isEmpty) {
      return emptyMessage;
    }
    return null;
  }

  static String? passwordValidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter your password';
    }
    return null;
  }
}
