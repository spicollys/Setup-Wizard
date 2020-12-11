import 'package:form_field_validator/form_field_validator.dart';

class ValidationController {
  static final ValidationController instance = ValidationController._();
  ValidationController._();

  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'Please enter a password.'),
    MinLengthValidator(8, errorText: 'Password must be at least 8 digits.')
  ]);

  final emailValidator =
      EmailValidator(errorText: 'Please enter a valid email address.');
}
