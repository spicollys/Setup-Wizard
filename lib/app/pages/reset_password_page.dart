import 'package:flutter/material.dart';
import 'package:setup_wizard/app/components/constants.dart';
import 'package:setup_wizard/app/components/custom_flushbar.dart';
import 'package:setup_wizard/app/components/custom_gradient_container_grey.dart';
import 'package:setup_wizard/app/components/custom_submit_button.dart';
import 'package:setup_wizard/app/components/logo_setup_wizard.dart';
import 'package:setup_wizard/app/components/text_field_container.dart';
import 'package:setup_wizard/app/controllers/validation_controller.dart';
import 'package:setup_wizard/app/services/auth.dart';

class ResetPasswordPage extends StatefulWidget {
  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _email = TextEditingController();

  void clearText() {
    _email.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomGradientContainerGrey(
          child: Column(
            children: [
              Flexible(flex: 2, child: LogoSetupWizard()),
              TextFieldContainer(
                child: TextFormField(
                  validator: ValidationController.emailValidator,
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(color: Constants.white),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 11),
                    errorStyle:
                        TextStyle(height: 0.05, color: Constants.yellow700),
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
              CustomSubmitButton(
                  title: 'enviar',
                  onPressed: () {
                    Auth.instance.resetPassword(_email.text);
                    clearText();
                    CustomFlushBar.show(context: context, title: "Email enviado com sucesso", message: "");
                  }),
              Text(
                "Check the receipt of the message in your email box",
                style: TextStyle(color: Constants.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
