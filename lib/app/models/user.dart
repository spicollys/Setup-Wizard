import 'package:setup_wizard/app/interfaces/user_interface.dart';

class UserData implements IUser {
  @override
  String email;

  @override
  String name;

  UserData({this.email, this.name});

  UserData.fromJson(Map<String, dynamic> json)
      : email = json['email'],
        name = json['name'];

  Map<String, dynamic> toJson() => {'email': email, 'name': name};

  @override
  String getName({name}) {
    return name;
  }

  @override
  String getEmail({email}) {
    return email;
  }

  @override
  void setName({name}) {
    this.name = name;
  }

  @override
  void setEmail({email}) {
    this.email = email;
  }
}
