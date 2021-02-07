import 'package:flutter/material.dart';
import 'package:setup_wizard/app/components/constants.dart';

class CustomGradientContainerBlueGrey extends StatelessWidget {
  final Widget child;
  CustomGradientContainerBlueGrey({@required this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          Constants.blueGrey300,
          Constants.blueGrey400,
          Constants.blueGrey600,
          Constants.blueGrey700,
        ]),
      ),
    );
  }
}
