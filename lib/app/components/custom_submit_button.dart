import 'package:flutter/material.dart';

class CustomSubmitButton extends StatelessWidget {
  final String title;
  final void Function() onPressed;

  CustomSubmitButton({@required this.title, this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.07,
        margin: EdgeInsets.only(top: 10, bottom: 10),
        child: FlatButton(
          onPressed: onPressed,
          child: Text(
            title.toUpperCase(),
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          color: Colors.blueGrey[600],
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(
                width: 2,
                color: Colors.white,
              )),
        ),
      ),
    );
  }
}
