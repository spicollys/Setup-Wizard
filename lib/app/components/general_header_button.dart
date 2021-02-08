import 'package:flutter/material.dart';
import 'package:setup_wizard/app/models/argument.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants.dart';

class GeneralHeaderButton extends StatelessWidget {
  final String title;
  final String route;
  GeneralHeaderButton({@required this.title, @required this.route});

  @override
  Widget build(BuildContext context) {
    Argument _localArgument = Argument(arguments: [title, null]);

    return Container(
      height: MediaQuery.of(context).size.height / 5,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
        child: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
            side: BorderSide(color: Constants.white),
          ),
          elevation: 8,
          color: Constants.cyan800,
          onPressed: () =>
              Navigator.pushNamed(context, route, arguments: _localArgument),
          child: Center(
            child: Text(
              title,
              style: GoogleFonts.lato(
                color: Constants.white,
                fontSize: 26,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
