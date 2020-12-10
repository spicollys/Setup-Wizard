import 'package:flutter/material.dart';
import 'package:setup_wizard/app/components/text_field_container.dart';


class LoginPage extends StatefulWidget{
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(

          child: Align(
            alignment: Alignment(
              0, 0.5
            ),

            child: Wrap(
              alignment: WrapAlignment.center,
              children: [

                TextFieldContainer(
                  child: TextField(
                    decoration: InputDecoration(
                      icon: Icon(Icons.person, color: Colors.grey[300],),
                      hintText: "E-mail",
                      border: InputBorder.none,
                    ),
                  ),

                ),
                TextFieldContainer(
                  child: TextField(
                    decoration: InputDecoration(
                      icon: Icon(Icons.vpn_key, color: Colors.grey[300],),
                      hintText: "Password",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    FlatButton(onPressed: () => null, child: Text("Login", style: TextStyle(
                      color: Colors.grey[300],
                    ),), color: Colors.blueGrey, ),
                  ],
                ),
                SizedBox(width: 15,),
                FlatButton(onPressed: null, child: Text("Not registered? Sign Up!", style: TextStyle(color: Colors.white70,),),)
              ],
            ),
          ),

          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('lib/app/assets/images/logo1.png'),
              scale: 1.7,
              alignment: Alignment.topCenter,
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

