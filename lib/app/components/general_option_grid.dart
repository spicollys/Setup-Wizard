import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:setup_wizard/app/interfaces/general_controller_interface.dart';
import 'package:setup_wizard/app/models/argument.dart';
import 'constants.dart';

class GeneralOptionGrid extends StatelessWidget {
  final IFilterCategoryController controllerInstance;
  GeneralOptionGrid({@required this.controllerInstance});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      physics: ClampingScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      crossAxisCount: 2,
      childAspectRatio: 2.5,
      children:
          List.generate(controllerInstance.getOptionList().length, (index) {
        Argument _localArgument =
            Argument(arguments: controllerInstance.filterOption(index));
        return Padding(
          padding: EdgeInsets.all(5),
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            color: Constants.blueGrey600,
            onPressed: () => Navigator.pushNamed(context, '/gameListPagination',
                arguments: _localArgument),
            child: FittedBox(
              fit: BoxFit.fitHeight,
              child: Text(
                controllerInstance.getOptionList()[index],
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
