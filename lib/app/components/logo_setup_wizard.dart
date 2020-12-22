import 'package:flutter/material.dart';

class LogoSetupWizard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      child: Image.asset(
        "lib/assets/images/logo1.png",
        fit: BoxFit.scaleDown,
        scale: 1.5,
      ),
    );
  }
}
