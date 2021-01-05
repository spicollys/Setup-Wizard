import 'package:flutter/material.dart';
import 'package:setup_wizard/app/components/constants.dart';
import 'package:setup_wizard/app/services/auth/auth.dart';

class DrawerHome extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const DrawerHome({Key key, this.scaffoldKey}) : super(key: key);

  @override
  _DrawerHomeState createState() => _DrawerHomeState();
}

class _DrawerHomeState extends State<DrawerHome> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Container(
          color: Constants.blueGrey200,
          child: Column(
            children: <Widget>[
              FlatButton(
                splashColor: Colors.transparent,
                padding: EdgeInsets.all(8),
                onPressed: () => null,
                child: CircleAvatar(
                  child: Icon(
                    Icons.person,
                    size: 35,
                  ),
                  radius: 35,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              FlatButton(
                onPressed: () => null,
                child: ListTile(
                  title: Text("My Saved Games"),
                  leading: Builder(
                    builder: (BuildContext context) {
                      return Icon(
                        IconData(60088, fontFamily: 'MaterialIcons'),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              FlatButton(
                onPressed: () => null,
                child: ListTile(
                  title: Text("Favorite Setups"),
                  leading: Builder(
                    builder: (BuildContext context) {
                      return Icon(
                        IconData(0xea22, fontFamily: 'MaterialIcons'),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 362,
              ),
              FlatButton(
                onPressed: () {
                  Auth.instance.signOut();
                },
                child: ListTile(
                  title: Text("LogOut"),
                  leading: Builder(
                    builder: (BuildContext context) {
                      return Icon(Icons.logout);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
