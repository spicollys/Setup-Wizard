abstract class IUser {
  String userId;
  String name;
  String email;
  String password;

  String getUserId({userId});
  String getName({name});
  String getEmail({email});
  String getPasswword({password});

  void setUserId({userId});
  void setName({name});
  void setEmail({email});
  void setPasswword({password});
}