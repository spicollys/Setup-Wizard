import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:setup_wizard/app/services/favorite_service.dart';

class FavoriteController{
  static final FavoriteController instance = FavoriteController._();
  FavoriteController._();

  Map<String, dynamic> favoriteMap = Map<String, dynamic>();

  void favoriteData(Function callBack) {
    User firebaseUser = FirebaseAuth.instance.currentUser;
    DocumentReference favoriteReference =
    FirebaseFirestore.instance.collection('favorite').doc(firebaseUser.uid);
    favoriteReference.get().then((value) {
      favoriteMap = value.data();
      callBack();
    });
  }

  bool isFavorite(int id) {
    MapEntry entry = favoriteMap.entries.firstWhere(
            (element) => element.key == id.toString(),
        orElse: () => null);
    return entry != null ? entry.value : false;
  }

  Widget isFavoriteIcon(int id) {
    if (isFavorite(id)) {
      return Icon(
        Icons.favorite,
        color: Colors.red,
        size: 40.0,
      );
    } else {
      return Icon(
        Icons.favorite,
        color: Colors.grey,
        size: 40.0,
      );
    }
  }

  void favorite(int id) {
    if (isFavorite(id)) {
      Favorite.instance.removeItem(id);
    } else {
      Favorite.instance.storageFavoriteIntoFirestore(id);
    }
  }
}