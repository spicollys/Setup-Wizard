import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:setup_wizard/app/components/custom_gradient_container_bluegrey.dart';
import 'package:setup_wizard/app/services/favorite_service.dart';
import 'package:setup_wizard/app/models/argument.dart';

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  User firebaseUser = FirebaseAuth.instance.currentUser;
  CollectionReference favoriteCollection =
      FirebaseFirestore.instance.collection("favorite");
  List<DocumentReference> listDocument = List<DocumentReference>();
  Map<String, dynamic> items = Map<String, dynamic>();

  @override
  void initState() {
    getFavoriteData();
    super.initState();
  }

  void getFavoriteData() {
    User firebaseUser = FirebaseAuth.instance.currentUser;
    DocumentReference favoriteRef =
        FirebaseFirestore.instance.collection('favorite').doc(firebaseUser.uid);
    favoriteRef.get().then((value) {
      items = value.data();
      setState(() {});
    });
  }

  void loadingList() {
    listDocument = [];
    var favoriteItems =
        items.entries.where((element) => element.value != false);
    favoriteItems.forEach((element) {
      listDocument.add(FirebaseFirestore.instance
          .collection('steam-game-data')
          .doc("${element.key}"));
    });
  }

  @override
  Widget build(BuildContext context) {
    loadingList();
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
                      onTap: () async {
                        await Navigator.pushNamed(context, '/gameInfoPage',
                            arguments: documentAsArgument);
                        getFavoriteData();
                      },
                      child: Card(
                        elevation: 2.0,
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage('${snapshot.data['headerImage']}'),
                          ),
                          trailing: IconButton(
                            icon: Icon(
                              Icons.favorite,
                              color: Colors.red,
                              size: 40,
                            ),
                            onPressed: () {
                              setState(() {
                                Favorite.instance
                                    .removeItem(snapshot.data['documentId']);
                                getFavoriteData();
                              });
                            },
                          ),
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
