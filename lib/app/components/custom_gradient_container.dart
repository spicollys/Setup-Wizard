import 'package:flutter/material.dart';

class CustomGradientContainer extends StatelessWidget {
  final Widget child;
  CustomGradientContainer({@required this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          Colors.grey[300],
          Colors.grey[400],
          Colors.grey,
          Colors.grey[600],
        ]),
      ),
    );
  }
}
