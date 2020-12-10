import 'package:flutter/material.dart';
import 'package:setup_wizard/app/components/text_field_container.dart';

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
              padding: EdgeInsets.only(top: _size.height * 0.15),
              child: Form(
                key: _formKey,
                child: Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    TextFieldContainer(
                      child: TextField(
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(color: Colors.grey[300]),
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.person,
                            color: Colors.grey[300],
                          ),
                          hintText: "E-mail",
                          hintStyle: TextStyle(color: Colors.grey[300]),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    TextFieldContainer(
                      child: TextField(
                        keyboardType: TextInputType.visiblePassword,
                        style: TextStyle(color: Colors.grey[300]),
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.vpn_key,
                            color: Colors.grey[300],
                          ),
                          hintText: "Password",
                          hintStyle: TextStyle(color: Colors.grey[300]),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Center(
                      child: SizedBox(
                        width: _size.width * 0.8,
                        child: FlatButton(
                          onPressed: () => null,
                          child: Text(
                            "Login".toUpperCase(),
                            style: TextStyle(
                              color: Colors.grey[300],
                            ),
                          ),
                          color: Colors.blueGrey,
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
                            color: Colors.white70,
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
              image: AssetImage('lib/app/assets/images/logo1.png'),
              scale: 1.7,
              alignment: Alignment(0, -0.8),
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
