import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:setup_wizard/app/pages/favorite_page.dart';
import 'package:setup_wizard/app/pages/game_genre_page.dart';
import 'package:setup_wizard/app/pages/game_info_page.dart';
import 'package:setup_wizard/app/pages/game_list_pagination_genre_page.dart';
import 'package:setup_wizard/app/pages/homepage.dart';
import 'package:setup_wizard/app/pages/login_page.dart';
import 'package:setup_wizard/app/pages/register_page.dart';
import 'app/pages/game_cluster_page.dart';
import 'app/pages/game_list_pagination_cluster_page.dart';
import 'app/pages/game_list_pagination_genre_page.dart';
import 'app/pages/loading_page.dart';
import 'app/pages/reset_password_page.dart';

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
        initialRoute: '/homePage',
        routes: {
          '/gameGenrePage': (context) => GameGenrePage(),
          '/gameListPaginationGenrePage': (context) => GameListPaginationGenrePage(),
          '/loginPage': (context) => LoginPage(),
          '/registerPage': (context) => RegisterPage(),
          '/loadingPage': (context) => LoadingPage(),
          '/resetPasswordPage': (context) => ResetPasswordPage(),
          '/gameInfoPage': (context) => GameInfoPage(),
          '/homePage': (context) => HomePage(),
          '/favoritePage': (context) => FavoritePage(),
          '/gameClusterPage': (context) => GameClusterPage(),
          '/gameListPaginationClusterPage': (context) => GameListPaginationClusterPage(),
          '/hardwareCategoryPage': (context) => null,
        });
  }
}
