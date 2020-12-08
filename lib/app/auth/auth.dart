import 'package:firebase_auth/firebase_auth.dart';
import 'package:setup_wizard/app/auth/usermanagement.dart';
import 'package:setup_wizard/app/models/user.dart';

abstract class Iauth {
  Future<User> signIn(String email, String password);
  Future<User> signUp(String email, String password, String name);
  void signOut();
}

class Auth implements Iauth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<User> signUp(String email, String password, String name) async{
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email.trim(), password: password);

      final User fireUser = userCredential.user;
      UserData userData = new UserData(email: email, name: name);

      await UserManagement(uid: fireUser.uid)
          .storeNewUser(userData); // Armazena os dados do usuário do store
      await fireUser.sendEmailVerification();
      return fireUser;
    } catch (e) {
      print("An error occured while trying to send email        verification");
      print(e.message);
      return null;
    }
  }

  @override
  Future<User> signIn(String email, String password) async{
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email.trim(), password: password);
      return userCredential.user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  void signOut() {
    FirebaseAuth.instance.signOut().then((value) {}).catchError((e) {
      print(e);
    });
  }

}