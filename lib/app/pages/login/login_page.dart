import 'package:flutter/material.dart';
import 'package:setup_wizard/app/components/text_field_container.dart';
import 'package:setup_wizard/app/controllers/validation_controller.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(top: _size.height * 0.16),
              child: Form(
                key: _formKey,
                child: Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    TextFieldContainer(
                      child: TextFormField(
                        validator: ValidationController.instance.emailValidator,
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
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
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
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
                    SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: InkWell(
                        onTap: () => null,
                        child: Text(
                          "Forgot your password?",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: SizedBox(
                        width: _size.width * 0.8,
                        height: _size.height * 0.07,
                        child: FlatButton(
                          onPressed: () => null,
                          child: Text(
                            "Login".toUpperCase(),
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          color: Colors.blueGrey[600],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(
                                width: 2,
                                color: Colors.white,
                              )),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    Center(
                      child: InkWell(
                        onTap: () => null,
                        child: Text(
                          "Not registered? Sign Up!",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('lib/assets/images/logo1.png'),
              scale: 1.7,
              alignment: Alignment(0, (-600 / _size.height)),
            ),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              colors: [
                Colors.grey[300],
                Colors.grey[400],
                Colors.grey,
                Colors.grey[600],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
