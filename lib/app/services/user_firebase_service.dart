import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:setup_wizard/app/interfaces/firebase_service_interface.dart';

class UserFirebaseService implements IFirebaseService {
  final CollectionReference _userServiceCollection =
      IFirebaseService.firebaseInstance.collection('user');

  static final UserFirebaseService instance =
      UserFirebaseService._(); //singleton

  UserFirebaseService._(); //private constructor

  @override
  Future<void> delete({String id}) async {
    await _userServiceCollection.doc(id).delete();
  }

  @override
  Future<DocumentSnapshot> get({String id}) async {
    DocumentSnapshot documentSnapshot =
        await _userServiceCollection.doc(id).get();
    return documentSnapshot;
  }

  @override
  Future put({String id, value}) async {
    return await _userServiceCollection.doc(id).set(value);
  }
}
