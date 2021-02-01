import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:setup_wizard/app/models/argument.dart';
import 'package:setup_wizard/app/services/game_data_firebase_service.dart';

class GameListPagination extends StatefulWidget {
  @override
  _GameListPaginationState createState() => _GameListPaginationState();
}

class _GameListPaginationState extends State<GameListPagination> {
  Future<String> collectionGameGenre;
  List<DocumentSnapshot> docs = [];
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
      print('No More Docs');
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
      querySnapshot = await GameDataFirebaseService.instance
          .getCollectionReferenceByGenre(genre: genre)
          .startAfterDocument(lastDocument)
          .limit(documentLimit)
          .get();
      print(1);
    }
    if (querySnapshot.docs.length < documentLimit) {
      hasMore = false;
    }

    lastDocument = querySnapshot.docs[querySnapshot.docs.length - 1];

    docs.addAll(querySnapshot.docs);
    _controller.sink.add(docs);

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
              return ListView.separated(
                  shrinkWrap: true,
                  reverse: false,
                  itemCount: snapshot.data.length,
                  controller: _scrollController,
                  separatorBuilder: (_, index) => Divider(
                        color: Colors.grey,
                      ),
                  itemBuilder: (_, index) {
                    final Argument documentAsArgument =
                        Argument(arguments: [snapshot.data[index]]);
                    return InkWell(
                      onTap: () => Navigator.pushNamed(context, '/gameInfoPage',
                          arguments: documentAsArgument),
                      child: ListTile(
                        title: Text(
                          '${snapshot.data[index]['queryName']}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                            'Release date: ${snapshot.data[index]['releaseDate']}'),
                      ),
                    );
                  });
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
}
