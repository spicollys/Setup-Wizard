import 'package:flutter/material.dart';
import 'package:setup_wizard/app/interfaces/general_controller_interface.dart';
import 'package:setup_wizard/app/models/argument.dart';
import 'constants.dart';

class GeneralOptionGrid extends StatelessWidget {
  final IFilterCategoryController controllerInstance;
  GeneralOptionGrid({@required this.controllerInstance});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      physics: ClampingScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      crossAxisCount: 2,
      children:
          List.generate(controllerInstance.getOptionList().length, (index) {
        Argument _localArgument =
            Argument(arguments: controllerInstance.filterOption(index));
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: RaisedButton(
            elevation: 8,
            color: Constants.grey600,
            onPressed: () => Navigator.pushNamed(context, '/gameListPage',
                arguments: _localArgument),
            child: FittedBox(
              fit: BoxFit.fill,
              child: Text(
                controllerInstance.getOptionList()[index],
                style: TextStyle(
                    fontSize: 24,
                    letterSpacing: 2,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        );
      }),
    );
  }
}
