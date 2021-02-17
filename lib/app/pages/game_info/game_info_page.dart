import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:setup_wizard/app/components/custom_container_text.dart';
import 'package:setup_wizard/app/components/custom_gradient_container_bluegrey.dart';
import 'package:setup_wizard/app/controllers/expandable_text_conroller.dart';
import 'package:setup_wizard/app/controllers/favorite_controller.dart';
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
  var document;

  _GameInfoPageState(this.document);

  @override
  void initState() {
    FavoriteController.instance.favoriteData(callBack);
    super.initState();
  }

  void callBack() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final Argument args = ModalRoute.of(context).settings.arguments;
    if (document != DocumentSnapshot) {
      document = args.arguments[0];
    }

    List<String> listOfInfo =
        GameInfoController.instance.listOfInfoValidation(document: document);

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
                        icon: FavoriteController.instance
                            .isFavoriteIcon(document['documentId']),
                        onPressed: () {
                          setState(() {
                            FavoriteController.instance
                                .favorite(document['documentId']);
                            // favoriteData();
                            FavoriteController.instance.favoriteData(callBack);
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
}
