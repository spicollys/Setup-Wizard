import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

class ErrorHandlerController {
  static final _log = Logger();

  static String singUpErrorHandling(FirebaseAuthException error) {
    String errorMessage;
    String errorLog;
    switch (error.code) {
      case "email-already-in-use":
        errorMessage = errorLog =
            "There already exists an account with the given email address.";
        break;
      case "invalid-email":
        errorMessage = errorLog = "The email address is not valid.";
        break;
      case "operation-not-allowed":
        errorLog =
            "Email/password accounts are not enabled. Enable email/password accounts in the Firebase Console, under the Auth tab.";
        errorMessage = "Internal error.";

        break;
      case "weak-password":
        errorMessage = errorLog = "The password is not strong enough.";
        break;
      default:
        errorMessage = "An undefined Error happened.";
    }
    _log.w("${DateTime.now()}: $errorLog", errorLog.toUpperCase());
    return errorMessage;
  }

  static String signInErrorHandling(FirebaseAuthException error) {
    String errorLog;
    String errorMessage;

    switch (error.code) {
      case "invalid-email":
        errorMessage = "Your email address appears to be malformed.";
        errorLog = "Invalid email.";
        break;
      case "wrong-password":
        errorMessage = errorLog = "Your password is wrong.";
        errorLog = "Wrong password.";
        break;
      case "user-not-found":
        errorMessage = "User with this email doesn't exist.";
        errorLog = "User not found.";
        break;
      case "user-disabled":
        errorMessage = "Internal error.";
        errorLog = "Disabled user.";
        break;
      default:
        errorMessage = "An undefined Error happened.";
    }
    _log.w("${DateTime.now()}: $errorLog", errorLog.toUpperCase());
    return errorMessage;
  }

  static void singOutErrorHandling(FirebaseAuthException error) {
    String errorLog;
    switch (error.code) {
      case "invalid-user-token":
        errorLog =
            "The user to be updated belongs to a diffent Firebase project";
        break;
      case "user-token-expired":
        errorLog = "The user to be updated is expired";
        break;
      case "null-user":
        errorLog = "The user to be updated is null.";
        break;
      case "tenant-id-mismatch":
        errorLog =
            "User's tenant ID does not match the underlying Auth instance's configured tenant ID.";
        break;
      default:
        errorLog = "An undefined Error happened.";
    }
    _log.w("${DateTime.now()}: $errorLog", errorLog.toUpperCase());
  }
}
