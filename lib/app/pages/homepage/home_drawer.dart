import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:setup_wizard/app/components/constants.dart';
import 'package:setup_wizard/app/models/user_data.dart';
import 'package:setup_wizard/app/services/auth/auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:setup_wizard/app/services/firebase_storage.dart';
import 'package:setup_wizard/app/services/user_firebase_service.dart';
import 'dart:io';

class DrawerHome extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const DrawerHome({Key key, this.scaffoldKey}) : super(key: key);

  @override
  _DrawerHomeState createState() => _DrawerHomeState();
}

void _logOut(BuildContext context) {
  Auth.instance.signOut();
  Navigator.pushNamedAndRemoveUntil(
      context, '/loginPage', (Route<dynamic> route) => false);
}

class _DrawerHomeState extends State<DrawerHome> {
  File _image;
  User _firebaseUser;
  String _imageFirebase;
  final picker = ImagePicker();
  Map<String, dynamic> _userDocument;

  @override
  void initState() {
    super.initState();
    setImage();
  }

  Future setImage() async {
    _userDocument = await getUserData();
    _imageFirebase = _userDocument['profilePicture'];

    setState(() {});
  }

  Future<Map<String, dynamic>> getUserData() async {
    _firebaseUser = FirebaseAuth.instance.currentUser;
    DocumentSnapshot userSnapshot =
        await UserFirebaseService.instance.get(id: _firebaseUser.uid);
    return userSnapshot.data();
  }

  Future _updateProfilePicture(File profilePicture) async {
    String pictureUrl;

    UserData userData = new UserData(email: _userDocument['email'], name: _userDocument['name']);
    String filename = 'profilePictureUser=' + _userDocument['email'].toString();

    await FirebaseStorageService.instance
        .put(value: profilePicture, filename: filename);
    pictureUrl = await FirebaseStorageService.instance.get(filename: filename);

    userData.setProfilePicture(profilePicture: pictureUrl);
    await UserFirebaseService.instance
        .put(id: _firebaseUser.uid, value: userData.toJson());
    setImage();
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _image = File(pickedFile.path);
      _updateProfilePicture(_image);
    } else {
      print('No image selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Constants.blueGrey200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child: _imageFirebase == null
                        ? Icon(
                            Icons.person,
                            size: 35,
                          )
                        : ClipOval(
                            child: Image.network(
                              _imageFirebase,
                              fit: BoxFit.cover,
                              width: 100,
                              height: 100,
                            ),
                          ),
                  ),
                ),
                FlatButton(
                  child: Icon(Icons.photo_camera),
                  onPressed: getImage,
                ),
              ],
            ),
            FlatButton(
              padding: EdgeInsets.only(top: 5, bottom: 5),
              onPressed: () => Navigator.pushNamed(context, '/favoritePage'),
              child: ListTile(
                title: Text("Favorite Games"),
                leading: Icon(Icons.videogame_asset),
              ),
            ),
            FlatButton(
              padding: EdgeInsets.only(top: 5, bottom: 5),
              onPressed: () => null,
              child: ListTile(
                title: Text("Favorite Setups"),
                leading: Icon(Icons.star),
              ),
            ),
            Expanded(
              child: Container(),
            ),
            FlatButton(
              padding: EdgeInsets.only(top: 5, bottom: 10),
              onPressed: () {
                _logOut(context);
              },
              child: ListTile(
                title: Text("LogOut"),
                leading: Icon(Icons.logout),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
