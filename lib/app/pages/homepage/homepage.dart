import 'package:setup_wizard/app/components/general_header_button.dart';

import 'home_drawer.dart';
import 'package:setup_wizard/app/components/constants.dart';
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
        appBar: AppBar(
          backgroundColor: Constants.blueGrey100,
          centerTitle: true,
          title: Text(
            'Setup Wizard',
            style: TextStyle(fontSize: 18, color: Constants.blueGrey700),
          ),
        ),
        key: _scaffoldKey,
        drawer: DrawerHome(scaffoldKey: _scaffoldKey),
        body: Stack(
          children: <Widget>[
            Container(
              child: Column(
                children: [
                  GeneralHeaderButton(
                      title: 'Game Categories'.toUpperCase(), route: '/gameGenrePage'),
                  GeneralHeaderButton(
                      title: 'Hardware Categories'.toUpperCase(),
                      route: '/hardwareCategoryPage'),
                  GeneralHeaderButton(title: 'Game Cluster'.toUpperCase(), route: '/gameClusterPage')
                ],
              ),
              decoration: BoxDecoration(
                gradient: Constants.blueGreyGradientPattern,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
