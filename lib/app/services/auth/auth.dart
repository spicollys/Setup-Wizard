import 'package:firebase_auth/firebase_auth.dart';
import 'package:setup_wizard/app/controllers/error_handler_controller.dart';
import 'package:setup_wizard/app/interfaces/user_interface.dart';
import 'package:setup_wizard/app/models/user_data.dart';
import 'package:setup_wizard/app/services/user_firebase_service.dart';
import 'dart:developer' as developer;

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  static final Auth instance = Auth._(); //singleton

  Auth._(); //private constructor

  Future<User> signUp(String email, String password, String name) async {
    User fireUser;
    String errorMessage;
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
              email: email.trim(), password: password);

      fireUser = userCredential.user;
      IUser userData = new UserData(email: email, name: name);

      await UserFirebaseService.instance
          .put(id: fireUser.uid, value: userData.toJson());

      await fireUser.sendEmailVerification();
      return fireUser;
    } on FirebaseAuthException catch (error) {
      errorMessage = ErrorHandlerController.singUpErrorHandling(error);
    }
    if (errorMessage != null) {
      developer.log(errorMessage);
      return Future.error(errorMessage);
    }
    return fireUser;
  }

  Future<User> signIn(String email, String password) async {
    User user;
    String errorMessage;
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email.trim(), password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (error) {
      errorMessage = ErrorHandlerController.signInErrorHandling(error);
    }
    if (errorMessage != null) {
      developer.log(errorMessage);
      return Future.error(errorMessage);
    }
    return user;
  }

  void signOut() {
    String errorMessage;
    try {
      FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (error) {
      errorMessage = ErrorHandlerController.singOutErrorHandling(error);
    }
    if (errorMessage != null) {
      developer.log(errorMessage);
    }
  }
}
