import 'dart:html';

import 'package:firebase_storage/firebase_storage.dart';

abstract class IFirebaseStorageService {
  static final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  Future get({String id});
  Future delete({String id});
  Future put({File value});
}
