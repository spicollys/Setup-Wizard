import 'package:firebase_auth/firebase_auth.dart';

class ErrorHandlerController {
  static String singUpErrorHandling(FirebaseAuthException error) {
    String errorMessage;
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
    return errorMessage;
  }

  static String signInErrorHandling(FirebaseAuthException error) {
    String errorMessage;
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
    return errorMessage;
  }

  static String singOutErrorHandling(FirebaseAuthException error) {
    String errorMessage;
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
    return errorMessage;
  }
}
