import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Favorite {
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("user");
  final CollectionReference favoriteCollection =
      FirebaseFirestore.instance.collection("favorite");
  User firebaseUser = FirebaseAuth.instance.currentUser;
  List<dynamic> list;
  Map<String, dynamic> favoriteItems = Map<String, dynamic>();

  static final Favorite instance = Favorite._();

  Favorite._();

  // Future<List<DocumentSnapshot>> returnList(
  //     DocumentReference documentReference) async {
  //   return await documentReference.snapshots().toList();
  // }

  void storageFavoriteIntoFirestore(int id) {
    DocumentReference documentReference =
        favoriteCollection.doc(firebaseUser.uid);
    if (documentReference != null) {
      documentReference.update({"$id": true});
    } else {
      documentReference.set({"$id": true});
    }
  }

  Map<String, dynamic> getFavoriteData() {
    DocumentReference favoriteRef = favoriteCollection.doc(firebaseUser.uid);
    favoriteRef.get().then((value) {
      favoriteItems = value.data();
    });
    return favoriteItems;
  }

  void removeItem(AsyncSnapshot snapshot, int index) {
    favoriteCollection
        .doc(firebaseUser.uid)
        .update({"$index": FieldValue.delete()});
  }
}
