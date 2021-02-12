
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:setup_wizard/app/components/custom_container_text.dart';
import 'package:setup_wizard/app/components/custom_gradient_container_bluegrey.dart';
import 'package:setup_wizard/app/controllers/expandable_text_conroller.dart';
import 'package:setup_wizard/app/controllers/game_info_controller.dart';
import 'package:setup_wizard/app/models/argument.dart';
import 'package:setup_wizard/app/services/favorite_service.dart';

class GameInfoPage extends StatefulWidget {
  final DocumentSnapshot document;
  const GameInfoPage({Key key, this.document}) : super(key: key);

  @override
  _GameInfoPageState createState() => _GameInfoPageState(this.document);
}

class _GameInfoPageState extends State<GameInfoPage> {
  DocumentSnapshot document;
  _GameInfoPageState(this.document);
  Map<String, dynamic> favoriteMap = Map<String, dynamic>();
  List<DocumentReference> listDocument = List<DocumentReference>();
  List list = [];

  @override
  void initState() {
    favoriteData();
    super.initState();
  }

  void favoriteData() {
    User firebaseUser = FirebaseAuth.instance.currentUser;
    DocumentReference favoriteReference =
        FirebaseFirestore.instance.collection('favorite').doc(firebaseUser.uid);
    favoriteReference.get().then((value) {
      favoriteMap = value.data();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {

    final Argument _receivedArgument = ModalRoute.of(context).settings.arguments;
    //final DocumentSnapshot document = _receivedArgument.arguments[0];
    final List<String> listOfInfo = GameInfoController.instance.listOfInfoValidation(document: document);


    return Scaffold(
      appBar: AppBar(
          title: Text("${document['queryName']}"),
          leading: Icon(Icons.videogame_asset)),
      body: CustomGradientContainerBlueGrey(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                constraints: BoxConstraints.expand(
                  height: 200.0,
                ),
                padding: EdgeInsets.symmetric(),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage("${document['headerImage']}"),
                  ),
                ),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      right: 10.0,
                      bottom: 10.0,
                      child: IconButton(
                        icon: isFavoriteIcon(document['documentId']),
                        onPressed: () {
                          setState(() {
                            favorite(document['documentId']);
                            favoriteData();
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
              CustomContainerText(
                child: Text(
                  "Minimum Specifications:\n\n"
                  "Graphic: ${listOfInfo[0]}\n"
                  "Processor: ${listOfInfo[1]}\n"
                  "Memory: ${listOfInfo[2]}\n"
                  "Others Requirements: ${listOfInfo[3]}\n\n\n"
                  "Recomended Specifications: \n\n"
                  "Graphic: ${listOfInfo[4]}\n"
                  "Processor: ${listOfInfo[5]}\n"
                  "Memory: ${listOfInfo[6]}\n"
                  "Others Requirements: ${listOfInfo[7]}",
                ),
              ),
              CustomContainerText(
                child: Text("Hardwares ranking\n\n"
                    "Minimum Graphic Ranking: ${document['GraphicsRankingMin']}\n"
                    "Recommended Graphic Ranking: ${document['GraphicsRankingRec']}\n\n"
                    "Minimum Memory Ranking: ${document['MemoryRankingMin']}\n"
                    "Recommended Memory Ranking: ${document['MemoryRankingRec']}\n\n"
                    "Minimum Processor Ranking: ${document['ProcessorRankingMinAdjusted']}\n"
                    "Recommended Processor Ranking: ${document['ProcessorRankingRecAdjusted']}"),
              ),
              CustomContainerText(
                child: ExpandableText(
                  document['aboutText'],
                  trimLines: 3,
                ),
              ),
              CustomContainerText(
                child: Text(
                    "Supported languages: ${document['supportedLanguages']}"),
              ),
              CustomContainerText(
                child: Text("Release Date: ${document['releaseDate']}"),
              )
            ],
          ),
        ),
      ),
    );
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
        color: Colors.white,
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
