import 'package:firebase_auth/firebase_auth.dart';
import 'package:setup_wizard/app/controllers/error_handler_controller.dart';
import 'package:setup_wizard/app/interfaces/user_interface.dart';
import 'package:setup_wizard/app/models/user_data.dart';
import 'package:setup_wizard/app/services/user_firebase_service.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  static final Auth instance = Auth._(); //singleton

  Auth._(); //private constructor

  Future<User> signUp(String email, String password, String name) async {
    User fireUser;
    UserCredential userCredential = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email.trim(), password: password)
        .then((credential) => credential)
        .catchError(
            (error) => throw ErrorHandlerController.singUpErrorHandling(error));

    fireUser = userCredential.user;
    IUser userData = new UserData(email: email, name: name);

    await UserFirebaseService.instance
        .put(id: fireUser.uid, value: userData.toJson());

    await fireUser.sendEmailVerification();
    return fireUser;
  }

  Future<User> signIn(String email, String password) async {
    UserCredential userCredential = await _firebaseAuth
        .signInWithEmailAndPassword(email: email.trim(), password: password)
        .then((credential) => credential)
        .catchError(
            (error) => throw ErrorHandlerController.signInErrorHandling(error));
    return userCredential.user;
  }

  void signOut() {
    FirebaseAuth.instance.signOut().catchError(
        (error) => ErrorHandlerController.singOutErrorHandling(error));
  }
}
