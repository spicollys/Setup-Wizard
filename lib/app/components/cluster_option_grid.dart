import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:setup_wizard/app/controllers/game_genre_controller.dart';
import 'package:setup_wizard/app/interfaces/general_controller_interface.dart';
import 'package:setup_wizard/app/models/argument.dart';
import 'constants.dart';


class ClusterOptionGrid extends StatelessWidget {
  List<String> _optionList = [
    "Cluster 0",
    "Cluster 1",
    "Cluster 2",
    "Cluster 3",
    "Cluster 4",
    "Cluster 5",
    "Cluster 6",
    "Cluster 7",
  ];
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      physics: ClampingScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      crossAxisCount: 2,
      childAspectRatio: 2.5,
      children:
      List.generate(_optionList.length, (index) {
        Argument _localArgument =
            Argument(arguments: [_optionList[index], index.toString()]);
        return Padding(
          padding: EdgeInsets.all(5),
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            color: Constants.blueGrey600,
            onPressed: () => Navigator.pushNamed(
                context, '/gameListPaginationClusterPage',
                arguments: _localArgument),
            child: FittedBox(
              fit: BoxFit.fitHeight,
              child: Text(
                _optionList[index],
                style: GoogleFonts.lato(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
