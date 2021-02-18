import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:setup_wizard/app/pages/%20favorite/favorite_page.dart';
import 'package:setup_wizard/app/pages/game_genre/game_genre_page.dart';
import 'package:setup_wizard/app/pages/game_info/game_info_page.dart';
import 'package:setup_wizard/app/pages/game_list_pagination/game_list_pagination_page.dart';
import 'package:setup_wizard/app/pages/homepage/homepage.dart';
import 'package:setup_wizard/app/pages/login/login_page.dart';
import 'package:setup_wizard/app/pages/register/register_page.dart';
import 'app/pages/game_list_pagination/game_list_pagination_page.dart';
import 'app/pages/loading/loading_page.dart';
import 'app/pages/reset_password/reset_password_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.grey,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/update',
        routes: {
          '/gameGenrePage': (context) => GameGenrePage(),
          '/gameListPaginationPage': (context) => GameListPaginationPage(),
          '/loginPage': (context) => LoginPage(),
          '/registerPage': (context) => RegisterPage(),
          '/loadingPage': (context) => LoadingPage(),
          '/resetPasswordPage': (context) => ResetPasswordPage(),
          '/gameInfoPage': (context) => GameInfoPage(),
          '/homePage': (context) => HomePage(),
          '/favoritePage': (context) => FavoritePage(),
          '/update': (context) => UpdateFirestoreData(),
          '/hardwareCategoryPage': (context) => null,
        });
  }
}

class UpdateFirestoreData extends StatelessWidget{


  final CollectionReference firestoreCollection = FirebaseFirestore.instance.collection("steam-game-data");

  Future loadJsonAsset() async {
    return await rootBundle.loadString('lib/assets/json/shuffled_df_15-02_execution.json');
  }

  Future parseJson() async {
    final String jsonFile = await loadJsonAsset();
    return json.decode(jsonFile);
  }

  Future<void> storageDataIntoFirestore() async {
    final Map parsedJson = await parseJson();

    for (var i = 9000; i < 12634; i++){
      var currentLine = parsedJson["$i"];
      if(currentLine == null){
        print(i);
        firestoreCollection.doc("$i").update({
          "Cluster": null,
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RawMaterialButton(
          fillColor: Colors.orange,
          onPressed: () => storageDataIntoFirestore(),
        ),
      ),
    );
  }
}
