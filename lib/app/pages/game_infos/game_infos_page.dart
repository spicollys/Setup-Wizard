import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:setup_wizard/app/components/custom_container_text.dart';
import 'package:setup_wizard/app/components/custom_gradient_container.dart';
import 'package:setup_wizard/app/controllers/game_infos_controller.dart';

class GameInfosPage extends StatefulWidget {
  const GameInfosPage({Key key, this.document}) : super(key: key);

  @override
  _GameInfosPageState createState() => _GameInfosPageState(this.document);

  final DocumentSnapshot document;
}

class _GameInfosPageState extends State<GameInfosPage> {
  _GameInfosPageState(this.document);

  DocumentSnapshot document;

  @override
  Widget build(BuildContext context) {
    List<String> listOfInfos =
        GameInfosController(document: document).listOfInfosValidations();

    return Scaffold(
      appBar: AppBar(
          title: Text("${document['queryName']}"),
          leading: Icon(Icons.videogame_asset)),
      body: CustomGradientContainer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.network("${document['headerImage']}"),
              CustomContainerText(
                  text: "Minimum Specifications:\n\n"
                      "Graphic: ${listOfInfos[0]}\n"
                      "Processor: ${listOfInfos[1]}\n"
                      "Memory: ${listOfInfos[2]}\n"
                      "Others Requirements: ${listOfInfos[3]}\n\n\n"
                      "Recomended Specifications: \n\n"
                      "Graphic: ${listOfInfos[4]}\n"
                      "Processor: ${listOfInfos[5]}\n"
                      "Memory: ${listOfInfos[6]}\n"
                      "Others Requirements: ${listOfInfos[7]}"),
              CustomContainerText(
                  text: "Description: \n\n ${document['aboutText']}"),
              CustomContainerText(text: "Supported languages: ${document['supportedLanguages']}",),
              CustomContainerText(text: "Release Date: ${document['releaseDate']}",)
            ],
          ),
        ),
      ),
    );
  }
}
