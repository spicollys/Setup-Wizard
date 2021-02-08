import 'package:flutter/material.dart';
import 'package:setup_wizard/app/components/constants.dart';

class CustomGradientContainerGrey extends StatelessWidget {
  final Widget child;
  CustomGradientContainerGrey({@required this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          Constants.grey300,
          Constants.grey400,
          Constants.grey,
          Constants.grey600,
        ]),
      ),
    );
  }
}
