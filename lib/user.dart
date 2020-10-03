import "dart:convert";

import 'package:flutter/material.dart';
import 'package:junkaday/junkList/fileUtils.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class User with ChangeNotifier {
  String key;
  String email;
  int health = 0;
  int maxHealth = 0;
  int mints = 0;
  bool isSpirit = false;
  int mintsWithSpirit = 0;
  int mileStone = 0;
  List<String> rewards;
  List<String> consumables;
  String lastUpdated;
  String createdDate;

  User(
      {this.key,
      this.email,
      this.health = 0,
      this.maxHealth = 0,
      this.mints = 0,
      this.isSpirit = false,
      this.mintsWithSpirit=0,
      this.mileStone = 0});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        key: json['key'],
        email: json['email'],
        health: json['health'],
        maxHealth: json['maxHealth'],
        mints: json['mints'],
        isSpirit: json['isSpirit'],
        mintsWithSpirit: json['mintsWithSpirit'],
        mileStone: json['mileStone']);
  }
  writeUserDetailsToFile() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    final filePath = '$path/JunkADayUserDetails';
    File file = File(filePath);
    file.writeAsStringSync(this.toString());
    notifyListeners();
  }

  setUserDetails(
      {String email,
      int health,
      int maxHealth,
      int mints,
      bool isSpirit,
      int mintsWithSpirit,
      int mileStone,
      String createdDate}) async {
    this.email = email ?? this.email;
    this.health = health ?? this.health;
    this.maxHealth = maxHealth ?? this.maxHealth;
    this.mints = mints ?? this.mints;
    this.isSpirit = isSpirit ?? this.isSpirit;
    this.mintsWithSpirit = mintsWithSpirit ?? this.mintsWithSpirit;
    this.mileStone = mileStone ?? this.mileStone;
    this.lastUpdated = DateTime.now().toString();
    this.createdDate =
        this.createdDate ?? FileUtils.getDateForFileName(DateTime.now());
    await FileUtils.writeUserDetailsToFile(this);
    notifyListeners();
  }

  String toString() {
    return json.encode({
      "key": key,
      "email": email,
      "health": health,
      "maxHealth": maxHealth,
      "mints": mints,
      "isSpirit": isSpirit,
      "mintsWithSpirit": mintsWithSpirit,
      "mileStone": mileStone,
      "lastUpdated": lastUpdated,
      "createdDate": createdDate
    });
  }
}
