import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

abstract class IFirebaseStorageService {
  static final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  Future<String> get({String filename});
  Future delete({String id});
  Future put({File value, String filename});
}
