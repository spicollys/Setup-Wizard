import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:setup_wizard/app/components/constants.dart';
import 'package:setup_wizard/app/components/custom_gradient_container_bluegrey.dart';
import 'package:setup_wizard/app/controllers/favorite_controller.dart';
import 'package:setup_wizard/app/controllers/log_controller.dart';
import 'package:setup_wizard/app/models/argument.dart';
import 'package:setup_wizard/app/services/game_data_firebase_service.dart';
import 'package:setup_wizard/app/services/user_firebase_service.dart';

class GameListPaginationPage extends StatefulWidget {
  @override
  _GameListPaginationPageState createState() => _GameListPaginationPageState();
}

class _GameListPaginationPageState extends State<GameListPaginationPage> {
  Future<String> collectionGameGenre;
  List<DocumentSnapshot> documentList = [];
  bool isLoading = false;
  bool hasMore = true;
  int documentLimit = 20;
  DocumentSnapshot lastDocument;
  ScrollController _scrollController = ScrollController();

  StreamController<List<DocumentSnapshot>> _controller =
      StreamController<List<DocumentSnapshot>>();

  Stream<List<DocumentSnapshot>> get _streamController => _controller.stream;

  @override
  void initState() {
    super.initState();
    collectionGameGenre = Future.delayed(Duration.zero, () {
      final Argument receivedArgument =
          ModalRoute.of(context).settings.arguments;
      return receivedArgument.arguments[1];
    });

    getDocs(collectionGameGenre);
    _scrollController.addListener(() {
      double maxScroll = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.position.pixels;
      double delta = MediaQuery.of(context).size.height * 0.20;
      if (maxScroll - currentScroll <= delta) {
        getDocs(collectionGameGenre);
      }
    });
  }

  getDocs(Future<String> collectionGameGenre) async {
    String genre = await collectionGameGenre;
    if (!hasMore) {
      LogController.logInfo('No more docs.');
      return;
    }
    if (isLoading) {
      return;
    }
    setState(() {
      isLoading = true;
    });
    QuerySnapshot querySnapshot;
    if (lastDocument == null) {
      querySnapshot = await GameDataFirebaseService.instance
          .getCollectionReferenceByGenre(genre: genre)
          .limit(documentLimit)
          .get();
    } else {
      LogController.logInfo('Limit reached, loading more 20 items...');
      querySnapshot = await GameDataFirebaseService.instance
          .getCollectionReferenceByGenre(genre: genre)
          .startAfterDocument(lastDocument)
          .limit(documentLimit)
          .get();
    }
    if (querySnapshot.docs.length < documentLimit) {
      hasMore = false;
    }

    lastDocument = querySnapshot.docs[querySnapshot.docs.length - 1];

    documentList.addAll(querySnapshot.docs);
    _controller.sink.add(documentList);

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Argument receivedArgument = ModalRoute.of(context).settings.arguments;
    final title = receivedArgument.arguments[0];
    return Scaffold(
      appBar: AppBar(title: Text(title), leading: Icon(Icons.videogame_asset)),
      body: StreamBuilder(
        stream: _streamController,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.none) {
            return Center(
              child: Text('None.'),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData && snapshot.data.length > 0) {
              return CustomGradientContainerBlueGrey(
                child: ListView.builder(
                    shrinkWrap: true,
                    reverse: false,
                    itemCount: snapshot.data.length,
                    controller: _scrollController,
                    itemBuilder: (_, index) {
                      final Argument documentAsArgument =
                          Argument(arguments: [snapshot.data[index]]);
                      return InkWell(
                        onTap: () => Navigator.pushNamed(
                            context, '/gameInfoPage',
                            arguments: documentAsArgument),
                        child: Card(
                          elevation: 2.0,
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage('${snapshot.data[index]['headerImage']}'),),
                            trailing: Icon(Icons.favorite_border),
                            title: Text(
                              '${snapshot.data[index]['queryName']}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                                'Release date: ${snapshot.data[index]['releaseDate']}'),
                          ),
                        ),
                      );
                    }),
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
      ),
    );
  }


  Future<Widget> FavoriteSystem(int id) async{
    return await Favorite.instance.isInFavoriteList(id) ? Icon(Icons.favorite, color: Colors.red,) : Icon(Icons.favorite_border);
  }
}
