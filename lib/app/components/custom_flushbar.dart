import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:setup_wizard/app/components/constants.dart';

class CustomFlushBar {
  static Future show(
      {@required BuildContext context,
      @required String title,
      @required String message}) async {
    return Flushbar(
      backgroundColor: Constants.blueGrey600,
      messageText: Text(
        message,
        style: TextStyle(fontSize: 18, color: Constants.white),
      ),
      titleText: Text(
        title,
        style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Constants.white),
      ),
      duration: Duration(seconds: 3),
    )..show(context);
  }
}
