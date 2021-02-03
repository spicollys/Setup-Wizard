import 'package:firebase_storage/firebase_storage.dart';
import 'package:setup_wizard/app/interfaces/firebase_storage_interface.dart';

class FireStorageService implements IFirebaseStorageService {
  final FirebaseStorage _firebaseStorage = IFirebaseStorageService.firebaseStorage;

  static final FireStorageService instance = FireStorageService._();

  FireStorageService._();

  @override
  Future delete({String id}) async{
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future get({String id}) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future put({dynamic value}) async{
    // TODO: implement get
    throw UnimplementedError();
  }
}
