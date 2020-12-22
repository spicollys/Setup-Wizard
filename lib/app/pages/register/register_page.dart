import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:setup_wizard/app/components/constants.dart';
import 'package:setup_wizard/app/components/custom_gradient_container.dart';
import 'package:setup_wizard/app/components/custom_submit_button.dart';
import 'package:setup_wizard/app/components/logo_setup_wizard.dart';
import 'package:setup_wizard/app/components/text_field_container.dart';
import 'package:setup_wizard/app/controllers/validation_controller.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  String _name;
  String _email;
  String _password;

  bool _validadeAndSave() {
    final FormState _form = _formKey.currentState;
    if (_form.validate()) {
      _form.save();
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomGradientContainer(
          child: Column(
            children: [
              Flexible(flex: 3, child: LogoSetupWizard()),
              Form(
                key: _formKey,
                child: Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    TextFieldContainer(
                      child: TextFormField(
                        validator: ValidationController.instance.textValidator,
                        onSaved: (String name) => _name = name,
                        style: TextStyle(color: Constants.white),
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 11),
                          errorStyle: TextStyle(
                              height: 0.05, color: Constants.yellow700),
                          icon: Icon(
                            Icons.person,
                            color: Constants.white,
                          ),
                          hintText: "Name",
                          hintStyle: TextStyle(color: Constants.grey300),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    TextFieldContainer(
                      child: TextFormField(
                        validator: ValidationController.instance.emailValidator,
                        onSaved: (String email) => _email = email,
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(color: Constants.white),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 11),
                          errorStyle: TextStyle(
                              height: 0.05, color: Constants.yellow700),
                          icon: Icon(
                            Icons.mail,
                            color: Constants.white,
                          ),
                          hintText: "E-mail",
                          hintStyle: TextStyle(color: Constants.grey300),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    TextFieldContainer(
                      child: TextFormField(
                        validator:
                            ValidationController.instance.passwordValidator,
                        onSaved: (String password) => _password = password,
                        onChanged: (String password) => _password = password,
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        style: TextStyle(color: Constants.white),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 11),
                          errorStyle: TextStyle(
                              height: 0.05, color: Constants.yellow700),
                          icon: Icon(
                            Icons.vpn_key,
                            color: Constants.white,
                          ),
                          hintText: "Password",
                          hintStyle: TextStyle(color: Constants.grey300),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    TextFieldContainer(
                      child: TextFormField(
                        validator: (_passwordConfirmation) {
                          if (_passwordConfirmation.isEmpty)
                            return 'This field can not be empty.';
                          return ValidationController.instance.matchValidator
                              .validateMatch(_password, _passwordConfirmation);
                        },
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        style: TextStyle(color: Constants.white),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 11),
                          errorStyle: TextStyle(
                              height: 0.05, color: Constants.yellow700),
                          icon: Icon(
                            Icons.vpn_key,
                            color: Constants.white,
                          ),
                          hintText: "Confirm password",
                          hintStyle: TextStyle(color: Constants.grey300),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    CustomSubmitButton(
                        title: 'register', onPressed: _validadeAndSave),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
