import 'package:flutter/material.dart';
import 'package:junkaday/user.dart';

class UserModel with ChangeNotifier {
  String _email;
  int _health;
  int _maxHealth;
  int _mints;
  bool _isSpirit;

  UserModel(email, health, maxHealth, mints, isSpirit) {
    this._email = email;
    this._health = health;
    this._maxHealth = maxHealth;
    this._mints = mints;
    this._isSpirit = isSpirit;
  }

  void setUserModel(email, health, maxHealth, mints, isSpirit) {
    this._email = email;
    this._health = health;
    this._maxHealth = maxHealth;
    this._mints = mints;
    this._isSpirit = isSpirit;
    notifyListeners();
  }

  User getUserDetails() {
    return new User(
        key: null,
        email: _email,
        health: _health,
        maxHealth: _maxHealth,
        mints: _mints,
        isSpirit: _isSpirit);
    // return {
    //   'email': this._email,
    //   'frownys': this._frownys,
    //   'health': this._health
    // };
  }
}
