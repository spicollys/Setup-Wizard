import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:setup_wizard/app/components/constants.dart';
import 'package:setup_wizard/app/components/custom_gradient_container.dart';
import 'package:setup_wizard/app/components/custom_inkwell.dart';
import 'package:setup_wizard/app/components/custom_flushbar.dart';
import 'package:setup_wizard/app/components/custom_submit_button.dart';
import 'package:setup_wizard/app/components/logo_setup_wizard.dart';
import 'package:setup_wizard/app/components/text_field_container.dart';
import 'package:setup_wizard/app/controllers/log_controller.dart';
import 'package:setup_wizard/app/controllers/validation_controller.dart';
import 'package:setup_wizard/app/services/auth/auth.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _email;
  String _password;

  @override
  Widget build(BuildContext context) {
    bool _validadeAndSave() {
      final FormState _form = _formKey.currentState;
      if (_form.validate()) {
        _form.save();
        return true;
      }
      return false;
    }

    void _validadeAndSubmit() async {
      if (_validadeAndSave()) {
        final User user =
            await Auth.instance.signIn(_email, _password).catchError((error) {
          CustomFlushBar.show(
              context: context, title: "Login error:", message: error);
          return null;
        });
        if (user != null) {
          LogController.logInfo('Well successed log in.');
          Navigator.of(context).popAndPushNamed('/gameGenrePage');
        }
      }
    }

    return Scaffold(
      body: SafeArea(
        child: CustomGradientContainer(
          child: Column(
            children: [
              Flexible(flex: 2, child: LogoSetupWizard()),
              Form(
                key: _formKey,
                child: Wrap(
                  alignment: WrapAlignment.center,
                  children: [
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
                        onSaved: (String password) => {_password = password},
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
                    CustomInkwell(
                      title: "Forgot your password?",
                      onTap: () => null,
                    ),
                    CustomSubmitButton(
                        title: 'login', onPressed: _validadeAndSubmit),
                    CustomInkwell(
                      title: "Not registered? Sign Up!",
                      onTap: () => Navigator.of(context)
                          .popAndPushNamed('/registerPage'),
                    ),
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
