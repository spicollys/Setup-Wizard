import 'package:flutter/material.dart';

class LogoSetupWizard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.05,
          bottom: MediaQuery.of(context).size.height * 0.05),
      child: Image.asset(
        "lib/assets/images/logo1.png",
        fit: BoxFit.scaleDown,
        scale: 1.5,
      ),
    );
  }
}
