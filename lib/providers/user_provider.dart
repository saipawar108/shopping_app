import 'package:flutter/material.dart';

import '../Model/userModel.dart';

class UserProvider extends ChangeNotifier {
  UserData _user = UserData(name: '', email: '', token: '');
  UserData get getuser => _user;
  void setUser(Map<String, dynamic> json) {
    _user = UserData.fromJson(json);
    notifyListeners();
  }
}
