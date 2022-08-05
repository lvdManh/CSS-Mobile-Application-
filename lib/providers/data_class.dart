import 'package:computer_service_system/models/user.dart';
import 'package:flutter/material.dart';



class DataClass extends ChangeNotifier {
  User _user = User(
    id: '',
    username: '',
    status: '',
    role: '',
    booking: [],
    deleted: false,
    createdAt: '',
    updatedAt: '',
    v: 0,
    accessToken: '',
    refreshToken: '',
  );
  User get user => _user;

  void setUser(String user){
    _user = User.fromJson(user);
    notifyListeners();
  }

  void setUserFromModel(User user){
    _user = user;
    notifyListeners();
  }


}