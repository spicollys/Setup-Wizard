import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:setup_wizard/app/components/constants.dart';
import 'package:setup_wizard/app/components/custom_flushbar.dart';
import 'package:setup_wizard/app/services/auth/auth.dart';
import 'package:image_picker/image_picker.dart';
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
  final picker = ImagePicker();

  Future _updateImagePicker(String imagePicker) async {
    User firebaseUser = FirebaseAuth.instance.currentUser;
    await Auth.instance
              .update(firebaseUser.uid, firebaseUser.email, firebaseUser.displayName, imagePicker)
              .catchError((error) {
                CustomFlushBar.show(
                  context: context, title: "Register error:", message: error);
                  });
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _updateImagePicker(_image.toString());
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
                          child: Image.file(
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
