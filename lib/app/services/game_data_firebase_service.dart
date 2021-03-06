import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:setup_wizard/app/interfaces/firebase_service_interface.dart';

class GameDataFirebaseService implements IFirebaseService {
  final CollectionReference _gameServiceCollection =
      IFirebaseService.firebaseInstance.collection("steam-game-data");
  final CollectionReference favoriteCollection =
      FirebaseFirestore.instance.collection("favorite");
  User firebaseUser = FirebaseAuth.instance.currentUser;
  static final GameDataFirebaseService instance =
      GameDataFirebaseService._(); //singleton

  GameDataFirebaseService._(); //private constructor

  @override
  Future<void> delete({String id}) async {
    await _gameServiceCollection.doc(id).delete();
  }

  @override
  Future<DocumentSnapshot> get({String id}) async {
    DocumentSnapshot documentSnapshot =
        await _gameServiceCollection.doc(id).get();
    return documentSnapshot;
  }

  @override
  Future put({String id, value}) async {
    //TODO - value need to be a mapped object
    await _gameServiceCollection.doc(id).set(value);
  }

  CollectionReference getCollection() => _gameServiceCollection;

  Query getCollectionReferenceByGenre({@required String genre}) {
    print(genre);
    return (genre == null)
        ? _gameServiceCollection
        : _gameServiceCollection.where(genre, isEqualTo: true);
  }
  Query getCollectionReferenceByCluster({@required String cluster}) {
    return (cluster == null)
        ? _gameServiceCollection.where('Cluster', isNull: true)
        : _gameServiceCollection.where('Cluster', isEqualTo: cluster);
  }
}
