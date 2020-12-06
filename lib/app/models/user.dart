import 'package:setup_wizard/app/interfaces/user_interface.dart';

class User extends IUser {
  //static final User userInstance = User._();

  User();

  User.pullUser(String email, String password) {
    //code to pull User from database
  }
  
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
  String getPasswword({password}) {
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
  void setPasswword({password}) {
    this.password = password;
  }
}
