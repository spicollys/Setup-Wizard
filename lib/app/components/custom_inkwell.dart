import 'package:flutter/material.dart';

import 'constants.dart';

class CustomInkwell extends StatelessWidget {
  final String title;
  final void Function() onTap;
  CustomInkwell({@required this.title, this.onTap});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 4, bottom: 4),
      child: Center(
        child: InkWell(
          onTap: () => onTap,
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Constants.white,
            ),
          ),
        ),
      ),
    );
  }
}
