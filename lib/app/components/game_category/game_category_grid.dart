import 'package:flutter/material.dart';
import 'package:setup/app/pages/game_category/controller/game_category_controller.dart';


class GameCategoryGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      physics: ClampingScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      crossAxisCount: 2,
      children:
          List.generate(GameCategoryController.categoriesList.length, (index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: RaisedButton(
            elevation: 8,
            color: Colors.grey[600],
            onPressed: () =>
                GameCategoryController.instance.filterCategory(index),
            child: FittedBox(
              fit: BoxFit.fill,
              child: Text(
                GameCategoryController.categoriesList[index],
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
