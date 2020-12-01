import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:setup_wizard/app/components/game_genre/game_genre_grid.dart';
import 'package:setup_wizard/app/components/game_genre/all_genre_button.dart';

class GameGenrePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Game Genres"),
        leading: Icon(Icons.videogame_asset),
      ),
      body: Container(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            AllGenreButton(),
            GameGenreGrid(),
          ],
        ),
      ),
    );
  }
}
