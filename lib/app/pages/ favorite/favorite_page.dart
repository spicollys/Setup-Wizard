import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:setup_wizard/app/components/custom_gradient_container_bluegrey.dart';
import 'package:setup_wizard/app/controllers/favorite_controller.dart';
import 'package:setup_wizard/app/models/argument.dart';

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  User firebaseUser = FirebaseAuth.instance.currentUser;
  CollectionReference favoriteCollection =
      FirebaseFirestore.instance.collection("favorite");
  List<dynamic> list = [];
  List<DocumentReference> listDocument = List<DocumentReference>();
  Map<String, dynamic> favoriteItems = Map<String, dynamic>();

  @override
  void initState() {
    Favorite.instance
        .getFavoriteData()
        .then((value) => setState(() => favoriteItems = value));
    super.initState();
  }

  void loadingList() {
    list = favoriteItems.keys.toList();
    list.forEach((index) {
      listDocument.add(FirebaseFirestore.instance
          .collection('steam-game-data')
          .doc("$index"));
    });
  }

  void removeFavoriteItem({int index, int id}) {
    Favorite.instance.removeItem(id);
    listDocument.removeAt(index);
  }

  @override
  Widget build(BuildContext context) {
    if (listDocument.isEmpty && favoriteItems != null) {
      loadingList();
    }
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
                          trailing: IconButton(
                            icon: Icon(
                              Icons.favorite,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              setState(() {
                                removeFavoriteItem(
                                    index: index,
                                    id: snapshot.data['documentId']);
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
