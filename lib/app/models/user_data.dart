import 'package:setup_wizard/app/interfaces/user_interface.dart';

class UserData implements IUser {
  @override
  String email;

  @override
  String name;

  String profilePicture;

  UserData({this.email, this.name});

  UserData.fromJson(Map<String, dynamic> json)
      : email = json['email'],
        name = json['name'],
        profilePicture = json['profilePicture'];

  @override
  Map<String, dynamic> toJson() =>
      {'email': email, 'name': name, 'profilePicture': profilePicture};

  @override
  String getName({name}) {
    return name;
  }

  @override
  String getEmail({email}) {
    return email;
  }

  String getProfilePicture({profilePicture}) {
    return profilePicture;
  }

  @override
  void setName({name}) {
    this.name = name;
  }

  @override
  void setEmail({email}) {
    this.email = email;
  }

  void setProfilePicture({profilePicture}) {
    this.profilePicture = profilePicture;
  }
}
