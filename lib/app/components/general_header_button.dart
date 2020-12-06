import 'package:flutter/material.dart';
import 'package:setup_wizard/app/models/argument.dart';

class GeneralHeaderButton extends StatelessWidget {
  final String title;
  GeneralHeaderButton({@required this.title});

  @override
  Widget build(BuildContext context) {
    Argument _localArgument = Argument(arguments: [title, null]);

    return Container(
      height: MediaQuery.of(context).size.height / 5,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
        child: RaisedButton(
          elevation: 8,
          color: Colors.grey[600],
          onPressed: () => Navigator.pushNamed(context, '/gameListPage',
              arguments: _localArgument),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 24, letterSpacing: 2, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
