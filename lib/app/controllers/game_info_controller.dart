import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GameInfoController {
  static final GameInfoController instance =
      GameInfoController._(); //singleton pattern

  GameInfoController._();

  String infoValidation(String text) => text != null ? text : "Not Specified";

  List<String> listOfInfoValidation({@required DocumentSnapshot document}) {
    String minimumGraphics = document.data()['minimumGraphics'];
    String recomendedGraphics = document.data()['recomendedGraphics'];
    String minimumProcessor = document.data()['minimumProcessor'];
    String recomendedProcessor = document.data()['recomendedProcessor'];
    String minimumMemory = document.data()['minimumMemory'];
    String recomendedMemory = document.data()['recomendedMemory'];
    String minimumOtherRequirements =
        document.data()['minimumOtherRequirements'];
    String recomendedOtherRequirements =
        document.data()['recomendedOtherRequirements'];

    List<String> listOfInfo = [
      minimumGraphics,
      minimumProcessor,
      minimumMemory,
      minimumOtherRequirements,
      recomendedGraphics,
      recomendedProcessor,
      recomendedMemory,
      recomendedOtherRequirements
    ];

    listOfInfo
        .asMap()
        .forEach((key, value) => listOfInfo[key] = infoValidation(value));

    return listOfInfo;
  }
}
