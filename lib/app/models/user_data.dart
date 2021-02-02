import 'package:setup_wizard/app/interfaces/user_interface.dart';
import 'package:setup_wizard/app/services/auth/auth.dart';

class UserData implements IUser {
  @override
  String email;

  @override
  String name;

  String imagePicker;

  UserData({this.email, this.name});

  UserData.fromJson(Map<String, dynamic> json)
      : email = json['email'],
        name = json['name'],
        imagePicker = json['imagePicker'];

  @override
  Map<String, dynamic> toJson() => {'email': email, 'name': name, 'imagePicker': imagePicker};

  @override
  String getName({name}) {
    return name;
  }

  @override
  String getEmail({email}) {
    return email;
  }

  String getImagePicker({imagePicker}) {
    return imagePicker;
  }

  @override
  void setName({name}) {
    this.name = name;
  }

  @override
  void setEmail({email}) {
    this.email = email;
  }

  void setImagePicker({imagePicker}) {
    this.imagePicker = imagePicker;
  }
}
