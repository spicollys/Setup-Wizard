import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  String _imageFirebase;
  Map<String, dynamic> _userDocument;
  final picker = ImagePicker();
  User _firebaseUser = FirebaseAuth.instance.currentUser;

  @override
  void initState() async{
    super.initState();

    await setImage();
  }

  Future setImage() async {
    _userDocument = await getUserData();
    _imageFirebase = _userDocument['profilePicture'];
  }

  Future<Map<String, dynamic>> getUserData() async {
    DocumentSnapshot userSnapshot =
        await UserFirebaseService.instance.get(id: _firebaseUser.uid);
    return userSnapshot.data();
  }

  Future _updateProfilePicture(
      File profilePicture) async {
    UserData userData =
        new UserData(email: _userDocument['email'], name: _userDocument['name']);

    String filename = 'i' +
        profilePicture
            .toString()
            .substring(52, profilePicture.toString().length);
    var snapshot = FirebaseStorageService.instance
        .put(value: profilePicture, filename: filename);
    String downloadUrl =
        await FirebaseStorageService.instance.get(value: snapshot);

    userData.setProfilePicture(profilePicture: downloadUrl);
    await UserFirebaseService.instance
        .put(id: _firebaseUser.uid, value: userData.toJson());
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _updateProfilePicture(_image);
      } else {
        print('No image selected.');
      }
    });
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
            Center(
              child: FlatButton(
                splashColor: Colors.transparent,
                padding: EdgeInsets.all(15),
                onPressed: getImage,
                child: CircleAvatar(
                  child: _image == null
                      ? Icon(
                          Icons.person,
                          size: 35,
                        )
                      : ClipOval(
                          child: _imageFirebase != null
                              ? Image.network(
                                  _imageFirebase,
                                  fit: BoxFit.cover,
                                  width: 100,
                                  height: 100,
                                )
                              : Image.file(
                                  _image,
                                  fit: BoxFit.cover,
                                  width: 100,
                                  height: 100,
                                ),
                        ),
                  radius: 50,
                ),
              ),
            ),
            FlatButton(
              padding: EdgeInsets.only(top: 5, bottom: 5),
              onPressed: () => null,
              child: ListTile(
                title: Text("My Saved Games"),
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
