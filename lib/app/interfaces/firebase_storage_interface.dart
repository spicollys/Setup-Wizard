import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

abstract class IFirebaseStorageService {
  static final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  Future<String> get({TaskSnapshot value});
  Future delete({String id});
  TaskSnapshot put({File value, String filename});
}
