import 'package:cloud_firestore/cloud_firestore.dart';

abstract class IFirebaseService {
  static final FirebaseFirestore firebaseInstance = FirebaseFirestore.instance;

  Future get({String id});
  Future delete({String id});
  Future put({String id, dynamic value});
}
