import 'package:flutter/material.dart';

import 'constants.dart';

class CustomContainerText extends StatelessWidget {
  final Widget child;

  const CustomContainerText({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
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
          ],
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
