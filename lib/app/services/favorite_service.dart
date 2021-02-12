import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Favorite {
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("user");
  final CollectionReference favoriteCollection =
      FirebaseFirestore.instance.collection("favorite");

  static final Favorite instance = Favorite._();
  Favorite._();

  void storageFavoriteIntoFirestore(int id) {
    User firebaseUser = FirebaseAuth.instance.currentUser;
    DocumentReference documentReference =
        favoriteCollection.doc(firebaseUser.uid);
    if (documentReference != null) {
      documentReference.update({"$id": true});
    } else {
      documentReference.set({"$id": true});
    }
  }

  Future<Map<String, dynamic>> getFavoriteData() async {
    User firebaseUser = FirebaseAuth.instance.currentUser;
    Map<String, dynamic> favoriteItems = Map<String, dynamic>();
    DocumentReference favoriteRef = favoriteCollection.doc(firebaseUser.uid);
    print(FirebaseAuth.instance.currentUser.uid);
    await favoriteRef.get().then((value) {
      favoriteItems =  value.data();
    });
    favoriteItems.removeWhere((key, value) => value == false);
    print(favoriteItems);
    return favoriteItems;
  }

  void removeItem(int index) {
    User firebaseUser = FirebaseAuth.instance.currentUser;
    favoriteCollection
        .doc(firebaseUser.uid)
        .update({"$index": false});
  }
}
