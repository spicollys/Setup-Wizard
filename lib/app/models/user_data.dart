import 'dart:convert';

import 'package:setup_wizard/app/interfaces/user_interface.dart';

class UserData implements IUser {
  @override
  String email;

  @override
  String name;

  List<int> listOfFavorite;

  UserData({this.email, this.name, this.listOfFavorite});

  UserData.fromJson(Map<String, dynamic> json)
      : email = json['email'],
        name = json['name'],
        listOfFavorite = json['listOfFavorite'] as List<int>;

  @override
  Map<String, dynamic> toJson() {
    List<int> listOfFavorite = [];
    return {'email': email, 'name': name, 'listOfFavorite': listOfFavorite};
  }

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

  List<int> getListOfFavorite({listOfFavorite}) {
    return listOfFavorite;
  }

  void setListOfFavorite({listOfFavorite}) {
    this.listOfFavorite = listOfFavorite;
  }
}
