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
  Map<String, dynamic> fav;

  static final Favorite instance = Favorite._();

  Favorite._();

  Future<List<DocumentSnapshot>> returnList(
      DocumentReference documentReference) async {
    return await documentReference.snapshots().toList();
  }

  void storageFavoriteIntoFirestore(int id)  {
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection('favorite')
        .doc(firebaseUser.uid);
    if (documentReference != null) {
      documentReference.update({"$id": true});
    } else {
      documentReference.set({"$id": true});
    }
  }

  getFavoriteData(){
    DocumentReference favoriteRef =
    FirebaseFirestore.instance.collection('favorite').doc(firebaseUser.uid);
    favoriteRef.get().then((value) {
      fav = value.data();
    });
  }

  bool isFavorite(AsyncSnapshot snapshot, int index) => fav != null && fav.containsKey(snapshot.data[index]['documentId'].toString()) ? true : false;

  void removeItem(AsyncSnapshot snapshot, int index)  {
    favoriteCollection.doc(firebaseUser.uid).update({"$index": FieldValue.delete()});
  }
}
