import 'package:flutter/material.dart';
import 'package:setup_wizard/app/components/constants.dart';
import 'package:setup_wizard/app/services/auth.dart';
import 'package:setup_wizard/app/services/profile_picture_service.dart';

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

  @override
  void initState() {
    super.initState();
    ProfilePicture.instance.setImage(refreshPicture);
  }

  void refreshPicture(){
    setState(() {});
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
            Container(
              alignment: Alignment.center,
              child: InkWell(
                onTap: () async{
                  await ProfilePicture.instance.getImage();
                  ProfilePicture.instance.setImage(refreshPicture);
                },
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white,
                  child: ProfilePicture.instance.imageFirebase == null
                      ? Icon(
                          Icons.person,
                          size: 35,
                        )
                      : ClipOval(
                          child: Image.network(
                            ProfilePicture.instance.imageFirebase,
                            fit: BoxFit.cover,
                            width: 100,
                            height: 100,
                          ),
                        ),
                ),
              ),
            ),
            FlatButton(
              padding: EdgeInsets.only(top: 16, bottom: 8),
              onPressed: () => Navigator.pushNamed(context, '/favoritePage'),
              child: ListTile(
                title: Text("Favorite Games"),
                leading: Icon(Icons.videogame_asset),
              ),
            ),
            FlatButton(
              padding: EdgeInsets.only(top: 8, bottom: 8),
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
              padding: EdgeInsets.only(top: 8, bottom: 8),
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
