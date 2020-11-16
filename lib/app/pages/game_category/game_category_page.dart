import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:setup/app/components/game_category/game_category_grid.dart';
import 'package:setup/app/components/game_category/all_categories_button.dart';


class GameCategoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Game Category"),
        leading: Icon(Icons.videogame_asset),
      ),
      body: Container(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            AllCategoriesButton(),
            GameCategoryGrid(),
          ],
        ),
      ),
    );
  }
}
