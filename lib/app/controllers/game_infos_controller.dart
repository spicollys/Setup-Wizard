import 'package:cloud_firestore/cloud_firestore.dart';

class GameInfosController{
  
  final DocumentSnapshot document;

  GameInfosController({this.document});

  String infosValidation(String text) => text != null ? text : "Not Specified";

  List<String> listOfInfosValidations (){

    String minimumGraphics = document.data()['minimumGraphics'];
    String recomendedGraphics = document.data()['recomendedGraphics'];
    String minimumProcessor = document.data()['minimumProcessor'];
    String recomendedProcessor = document.data()['recomendedProcessor'];
    String minimumMemory = document.data()['minimumMemory'];
    String recomendedMemory = document.data()['recomendedMemory'];
    String minimumOtherRequirements = document.data()['minimumOtherRequirements'];
    String recomendedOtherRequirements =
    document.data()['recomendedOtherRequirements'];

    List<String> listOfInfos = [
      minimumGraphics,
      minimumProcessor,
      minimumMemory,
      minimumOtherRequirements,
      recomendedGraphics,
      recomendedProcessor,
      recomendedMemory,
      recomendedOtherRequirements
    ];

    listOfInfos.asMap().forEach((key, value) => listOfInfos[key] = infosValidation(value));

    return listOfInfos;
  }
}