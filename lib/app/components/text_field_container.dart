import 'package:flutter/material.dart';
import 'package:setup_wizard/app/components/constants.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  const TextFieldContainer({
    Key key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Align(
      alignment: Alignment.center,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        height: size.height * 0.07,
        width: size.width * 0.8,
        decoration: BoxDecoration(
          color: Constants.blueGrey400,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Constants.white, width: 2),
        ),
        child: child,
      ),
    );
  }
}
