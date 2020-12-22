import 'package:flutter/material.dart';
import 'package:setup_wizard/app/components/general_option_grid.dart';
import 'package:setup_wizard/app/components/general_header_button.dart';
import 'package:setup_wizard/app/controllers/game_genre_controller.dart';
import 'package:setup_wizard/app/services/auth/auth.dart';

class GameGenrePage extends StatelessWidget {
  void logOut(BuildContext context) {
    Auth.instance.signOut();
    Navigator.pushNamedAndRemoveUntil(
        context, '/loginPage', (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Game Genres"),
        leading: Icon(Icons.videogame_asset),
        actions: [
          FlatButton(child: Text("LogOut"), onPressed: () => logOut(context),)
        ],
      ),
      body: Container(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            GeneralHeaderButton(title: 'All games'),
            GeneralOptionGrid(
              controllerInstance: GameGenreController.instance,
            ),
          ],
        ),
      ),
    );
  }
}
