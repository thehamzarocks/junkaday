import 'package:flutter/material.dart';
import 'package:junkaday/user.dart';

class UserModel with ChangeNotifier {
  String _email;
  int _frownys;
  int _health;

  void setUserModel(email, frownys, health) {
    this._email = email;
    this._frownys = frownys;
    this._health = health;
    notifyListeners();
  }

  UserModel(this._email, this._frownys, this._health) {
    notifyListeners();
  }
  

  User getUserDetails() {
    return new User(key: null, email: _email, frownys:_frownys, health:_health);
    // return {
    //   'email': this._email,
    //   'frownys': this._frownys,
    //   'health': this._health
    // };
  }
}