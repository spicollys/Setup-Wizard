import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:setup_wizard/app/services/user_firebase_service.dart';

class Favorite {
  final CollectionReference firestoreCollection =
      FirebaseFirestore.instance.collection("user");
  User firebaseUser = FirebaseAuth.instance.currentUser;
  List<dynamic> list;

  static final Favorite instance = Favorite._();
  Favorite._();

  Future<void> storageFavoriteIntoFirestore(int id) async {
    await firestoreCollection.doc(firebaseUser.uid).update({
      "listOfFavorite": FieldValue.arrayUnion([id])
    });
  }
  Future<List<dynamic>> getFavoriteList()async{
    DocumentSnapshot dShot = await firestoreCollection.doc(firebaseUser.uid).get();
    return dShot.data()['listOfFavorite'];
  }

  Future<void> removeItem(int id) async {
    await firestoreCollection.doc(firebaseUser.uid).update({
      "listOfFavorite": FieldValue.arrayRemove([id])
    });
  }

   Future<bool> isInFavoriteList(int id)async{
    var list = await getFavoriteList();
    return list.contains(id);
  }
}
