import 'package:flutter/material.dart';
import 'package:setup_wizard/app/pages/game_genre/controller/game_genre_controller.dart';


class GameGenreGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      physics: ClampingScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      crossAxisCount: 2,
      children:
          List.generate(GameGenreController.genreList.length, (index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: RaisedButton(
            elevation: 8,
            color: Colors.grey[600],
            onPressed: () =>
                GameGenreController.instance.filterGenre(index),
            child: FittedBox(
              fit: BoxFit.fill,
              child: Text(
                GameGenreController.genreList[index],
                style: TextStyle(
                    fontSize: 24,
                    letterSpacing: 2,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        );
      }),
    );
  }
}
