import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants.dart';
import 'custom_flushbar.dart';

class HardwareContainerButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
          onPressed: () => CustomFlushBar.show(context: context, title: "Hardware Page", message: "Coming Soon" ),
          child: Center(
            child: Text(
              "HARDWARE CATEGORIES",
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
