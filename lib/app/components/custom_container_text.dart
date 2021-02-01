import 'package:flutter/material.dart';

import 'constants.dart';

class CustomContainerText extends StatelessWidget {
  final String text;

  const CustomContainerText({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(text),
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Constants.grey400,
          boxShadow: [
            BoxShadow(
                offset: const Offset(3.0, 3.0),
                blurRadius: 2.0,
                spreadRadius: 0.5,
                color: Constants.blueGrey400
            ),
          ]
      ),
    );
  }
}
