import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:setup_wizard/app/components/custom_gradient_container_bluegrey.dart';
import 'package:setup_wizard/app/controllers/favorite_controller.dart';
import 'package:setup_wizard/app/models/argument.dart';
import 'package:setup_wizard/app/services/game_data_firebase_service.dart';

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  bool isLoading = false;
  Map<String, dynamic> fav;
  User firebaseUser = FirebaseAuth.instance.currentUser;
  CollectionReference favoriteCollection =
      FirebaseFirestore.instance.collection("favorite");
  List list = [];
  List<DocumentReference> listDocument = List<DocumentReference>();
  List<Future<DocumentSnapshot>> futureDocReference =
      List<Future<DocumentSnapshot>>();
  Future<Map<String, dynamic>> futureItems;
  Map<String, dynamic> favoriteItems = Map<String, dynamic>();

  @override
  void initState(){
    getFavoriteItems();
    setState(() {});
    super.initState();
  }
  void getFavoriteItems(){
    Favorite.instance.getFavoriteData().then((value) {
      setState(() {
        favoriteItems = value;
        print(favoriteItems);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print("dentro $favoriteItems");
    list = favoriteItems.keys.toList();
    list.forEach((index) {
      listDocument.add(FirebaseFirestore.instance
          .collection('steam-game-data')
          .doc("$index"));
    });
    return Scaffold(
        appBar:
            AppBar(title: Text("Favorite List"), leading: Icon(Icons.favorite)),
        body: CustomGradientContainerBlueGrey(
            child: ListView.builder(
          itemCount: listDocument.length,
          itemBuilder: (_, index) {
            return FutureBuilder(
              future: listDocument[index].get(),
              builder: (_, snapshot) {
                if (snapshot.connectionState == ConnectionState.none) {
                  return Center(
                    child: Text('None.'),
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    final Argument documentAsArgument =
                        Argument(arguments: [snapshot.data]);
                    return InkWell(
                      onTap: () => Navigator.pushNamed(context, '/gameInfoPage',
                          arguments: documentAsArgument),
                      child: Card(
                        elevation: 2.0,
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage('${snapshot.data['headerImage']}'),
                          ),
                          // trailing: IconButton(
                          //   icon: isFavoriteIcon(snapshot, index),
                          //   onPressed: () {
                          //     setState(() {
                          //       favorite(snapshot, index);
                          //       favoriteData();
                          //     });
                          //   },
                          // ),
                          title: Text(
                            '${snapshot.data['queryName']}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                              'Release date: ${snapshot.data['releaseDate']}'),
                        ),
                      ),
                    );
                  } else {
                    return Center(
                      child: Text('No Data...'),
                    );
                  }
                } else {
                  return Text("return list");
                }
              },
            );
          },
        )));
  }
}
