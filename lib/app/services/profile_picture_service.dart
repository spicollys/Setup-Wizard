import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:setup_wizard/app/models/user_data.dart';
import 'package:setup_wizard/app/services/user_firebase_service.dart';
import 'firebase_storage.dart';

class ProfilePicture {
  static final ProfilePicture instance = ProfilePicture._(); //singleton

  ProfilePicture._(); //private constructor

  Map<String, dynamic> userDocument;
  String imageFirebase;
  final picker = ImagePicker();
  User _firebaseUser = FirebaseAuth.instance.currentUser;

  Future updateProfilePicture(File profilePicture) async {
    String pictureUrl;

    UserData userData =
        new UserData(email: userDocument['email'], name: userDocument['name']);
    String filename = 'profilePictureUser=' + userDocument['email'].toString();

    await FirebaseStorageService.instance
        .put(value: profilePicture, filename: filename);
    pictureUrl = await FirebaseStorageService.instance.get(filename: filename);

    userData.setProfilePicture(profilePicture: pictureUrl);
    await UserFirebaseService.instance
        .put(id: _firebaseUser.uid, value: userData.toJson());
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File image = File(pickedFile.path);
      await ProfilePicture.instance.updateProfilePicture(image);
    }
  }

  Future setImage(Function refreshState) async {
    ProfilePicture.instance.userDocument =
        await UserFirebaseService.instance.getUserData();
    ProfilePicture.instance.imageFirebase =
        ProfilePicture.instance.userDocument['profilePicture'];
    refreshState();
  }
}
