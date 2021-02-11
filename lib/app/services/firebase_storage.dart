import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:setup_wizard/app/interfaces/firebase_storage_interface.dart';

class FirebaseStorageService implements IFirebaseStorageService {
  final FirebaseStorage _firebaseStorage =
      IFirebaseStorageService.firebaseStorage;

  static final FirebaseStorageService instance = FirebaseStorageService._();

  FirebaseStorageService._();

  @override
  Future delete({String id}) async {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<String> get({TaskSnapshot value}) async {
    return await value.ref.getDownloadURL();
  }

  @override
  TaskSnapshot put({File value, String filename}) {
    return _firebaseStorage.ref().child('$filename').putFile(value).snapshot;
  }
}
