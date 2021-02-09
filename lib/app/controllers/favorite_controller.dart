import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:setup_wizard/app/services/user_firebase_service.dart';

class Favorite {
  final CollectionReference firestoreCollection =
      FirebaseFirestore.instance.collection("user");
  User firebaseUser = FirebaseAuth.instance.currentUser;

  static final Favorite instance = Favorite._();
  Favorite._();

  Future<void> storageFavoriteIntoFirestore(int id) async {
    await firestoreCollection.doc(firebaseUser.uid).update({
      "listOfFavorite": FieldValue.arrayUnion([id])
    });
  }
  Future<dynamic> getFavoriteList(){
    return firestoreCollection.doc(firebaseUser.uid).snapshots().forEach((element) => element.data()['listOfFavorite']);
  }
}
