import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:setup_wizard/app/components/constants.dart';

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
    initiateApp();
  }

  void initiateApp() {
    User firebaseUser = FirebaseAuth.instance.currentUser;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (firebaseUser != null) {
        Navigator.pushNamedAndRemoveUntil(
            context, '/gameGenrePage', (Route<dynamic> route) => false);
      } else {
        Navigator.pushNamedAndRemoveUntil(
            context, '/homePage', (Route<dynamic> route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.grey,
      body: CircularProgressIndicator(),
    );
  }
}
