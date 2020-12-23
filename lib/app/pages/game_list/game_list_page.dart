import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:setup_wizard/app/models/argument.dart';
import 'package:setup_wizard/app/pages/game_infos/game_infos_page.dart';
import 'package:setup_wizard/app/services/game_data_firebase_service.dart';

class GameListPage extends StatefulWidget {
  @override
  _GameListPageState createState() => _GameListPageState();
}

class _GameListPageState extends State<GameListPage> {
  @override
  Widget build(BuildContext context) {
    final Argument _receivedArgument =
        ModalRoute.of(context).settings.arguments;
    final _title = _receivedArgument.arguments[0];
    final _selectedOption = _receivedArgument.arguments[1];

    return Scaffold(
      appBar: AppBar(title: Text(_title), leading: Icon(Icons.videogame_asset)),
      body: StreamBuilder(
          stream: GameDataFirebaseService.instance
              .getCollectionSnapshotByGenre(genre: _selectedOption),
          builder: (_, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView.separated(
                  shrinkWrap: true,
                  itemCount: snapshot.data.documents.length,
                  separatorBuilder: (_, index) => Divider(
                        color: Colors.grey,
                      ),
                  itemBuilder: (_, index) {
                    final DocumentSnapshot document = snapshot.data.documents[index]; //TODO this will be passed when user clicks on tile
                    return InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GameInfosPage(
                                    document: document,
                                  ))),
                      child: ListTile(
                        title: Text(
                          '${snapshot.data.documents[index]['queryName']}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                            'Release date: ${snapshot.data.documents[index]['releaseDate']}'),
                      ),
                    );
                  });
            }
          }),
    );
  }
}
