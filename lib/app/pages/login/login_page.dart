import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:setup_wizard/app/components/custom_gradient_container.dart';
import 'package:setup_wizard/app/components/custom_inkwell.dart';
import 'package:setup_wizard/app/components/custom_submit_button.dart';
import 'package:setup_wizard/app/components/logo_setup_wizard.dart';
import 'package:setup_wizard/app/components/text_field_container.dart';
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

  bool _validadeAndSave() {
    final FormState _form = _formKey.currentState;
    if (_form.validate()) {
      _form.save();
      return true;
    }
    return false;
  }

  void _validadeAndSubmit() async {
    try {
      if (_validadeAndSave()) {
        final User user = await Auth.instance.signIn(_email, _password);
        print(user.uid);
      }
    } on FirebaseAuthException catch (error) {
      print(error);
      print(error.code);
      print(error.message);
    }
  }

  @override
  Widget build(BuildContext context) {
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
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 11),
                          errorStyle:
                              TextStyle(height: 0.05, color: Colors.yellow),
                          icon: Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                          hintText: "E-mail",
                          hintStyle: TextStyle(color: Colors.grey[300]),
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
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 11),
                          errorStyle:
                              TextStyle(height: 0.05, color: Colors.yellow),
                          icon: Icon(
                            Icons.vpn_key,
                            color: Colors.white,
                          ),
                          hintText: "Password",
                          hintStyle: TextStyle(color: Colors.grey[300]),
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
                      onTap: () => null,
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
