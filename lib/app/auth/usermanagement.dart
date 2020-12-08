import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';

class UserManagement {

  final String uid;
  UserManagement({this.uid});

  final CollectionReference userCollection = FirebaseFirestore.instance.collection('/user');

  Future storeNewUser(UserData user) async {
    return await userCollection.doc(uid).set({
      'name': user.name,
      'email': user.email,
    });
  }
}