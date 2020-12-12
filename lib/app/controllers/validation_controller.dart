import 'package:form_field_validator/form_field_validator.dart';

class ValidationController {
  static final ValidationController instance = ValidationController._();
  ValidationController._();

  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'Password field can not be empty.'),
    MinLengthValidator(8, errorText: 'Password must be at least 8 digits.')
  ]);

  final emailValidator = MultiValidator([
    RequiredValidator(errorText: 'E-mail field can not be empty.'),
    EmailValidator(errorText: 'Please enter a valid e-mail address.')
  ]);
}
