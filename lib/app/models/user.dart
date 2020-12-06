import 'package:setup_wizard/app/interfaces/user_interface.dart';

class User implements IUser {
  @override
  String email;

  @override
  String name;

  @override
  String password;

  @override
  String userId;

  User();

  User.fromJson(Map<String, dynamic> json)
      : userId = json['userId'],
        email = json['email'],
        password = json['password'],
        name = json['name'];

  Map<String, dynamic> toJson() =>
      {'userId': userId, 'email': email, 'password': password, 'name': name};

  @override
  String getUserId({userId}) {
    return userId;
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
  String getPassword({password}) {
    return password;
  }

  @override
  void setUserId({userId}) {
    this.userId = userId;
  }

  @override
  void setName({name}) {
    this.name = name;
  }

  @override
  void setEmail({email}) {
    this.email = email;
  }

  @override
  void setPassword({password}) {
    this.password = password;
  }
}
