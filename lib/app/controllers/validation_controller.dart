import 'package:form_field_validator/form_field_validator.dart';

class ValidationController {
  ValidationController._();

  static final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'Password field can not be empty.'),
    MinLengthValidator(6, errorText: 'Password must be at least 6 digits.')
  ]);

  static final emailValidator = MultiValidator([
    RequiredValidator(errorText: 'E-mail field can not be empty.'),
    EmailValidator(errorText: 'Please enter a valid e-mail address.')
  ]);

  static final textValidator = MultiValidator([
    RequiredValidator(errorText: 'This field can not be empty.'),
  ]);

  static final matchValidator =
      MatchValidator(errorText: 'Passwords aren\'t equal');
}
