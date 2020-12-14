import 'package:firebase_auth/firebase_auth.dart';
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
      switch (error.code) {
        case "email-already-in-use":
          errorMessage =
              "There already exists an account with the given email address.";
          break;
        case "invalid-email":
          errorMessage = "The email address is not valid.";
          break;
        case "operation-not-allowed":
          errorMessage =
              "Email/password accounts are not enabled. Enable email/password accounts in the Firebase Console, under the Auth tab.";
          break;
        case "weak-password":
          errorMessage = "The password is not strong enough.";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }
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
      switch (error.code) {
        case "invalid-email":
          errorMessage = "Your email address appears to be malformed.";
          break;
        case "wrong-password":
          errorMessage = "Your password is wrong.";
          break;
        case "user-not-found":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "user-disabled":
          errorMessage = "User with this email has been disabled.";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }
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
      switch (error.code) {
        case "invalid-user-token":
          errorMessage =
              "The user to be updated belongs to a diffent Firebase project";
          break;
        case "user-token-expired":
          errorMessage = "The user to be updated is expired";
          break;
        case "null-user":
          errorMessage = "The user to be updated is null.";
          break;
        case "tenant-id-mismatch":
          errorMessage =
              "User's tenant ID does not match the underlying Auth instance's configured tenant ID.";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }
    }
    if (errorMessage != null) {
      developer.log(errorMessage);
    }
  }
}
