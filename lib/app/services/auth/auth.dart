import 'package:firebase_auth/firebase_auth.dart';
import 'package:setup_wizard/app/interfaces/user_interface.dart';
import 'package:setup_wizard/app/models/user_data.dart';
import 'package:setup_wizard/app/services/user_firebase_service.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  static final Auth instance = Auth._(); //singleton

  Auth._(); //private constructor

  Future<User> signUp(String email, String password, String name) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
              email: email.trim(), password: password);

      final User fireUser = userCredential.user;
      IUser userData = new UserData(email: email, name: name);

      await UserFirebaseService.instance
          .put(id: fireUser.uid, value: userData.toJson());

      await fireUser.sendEmailVerification();
      return fireUser;
    } catch (e) {
      print("An error occured while trying to send email verification");
      print(e.message);
      return null;
    }
  }

  Future<User> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email.trim(), password: password);
      return userCredential.user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  void signOut() {
    FirebaseAuth.instance.signOut().then((value) {}).catchError((e) {
      print(e);
    });
  }
}
