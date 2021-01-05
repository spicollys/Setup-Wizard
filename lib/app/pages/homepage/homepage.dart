import 'home_drawer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar:  AppBar(
          backgroundColor: Colors.blueGrey[100],
          centerTitle: true,
          title: Text('Setup Wizard', style: TextStyle(fontSize: 30, color: Colors.blueGrey[700]),),
        ),
        key: _scaffoldKey,
        drawer: DrawerHome(scaffoldKey: _scaffoldKey),
        body: Stack(
          children: <Widget>[
            Container(
              child: Column(

              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  colors: [
                    Colors.blueGrey[200],
                    Colors.blueGrey[300],
                    Colors.blueGrey[400],
                    Colors.blueGrey,
                    Colors.blueGrey[600],
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
