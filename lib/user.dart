import "dart:convert";

import 'package:flutter/material.dart';
import 'package:junkaday/consumables/ConsumablesShopItem.dart';
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
  List<Map<String, dynamic>> consumables;
  String lastUpdated;
  String createdDate;

  User(
      {this.key,
      this.email,
      this.health = 0,
      this.maxHealth = 0,
      this.mints = 0,
      this.isSpirit = false,
      this.mintsWithSpirit = 0,
      this.consumables = const [],
      this.mileStone = 0});

  factory User.fromJson(Map<String, dynamic> userJson) {
    List<dynamic> consumablesJson = [];
    try {
      consumablesJson = json.decode(userJson['consumables']);
    } catch (e) {
      // do nothing, no consumables yet
    }
    // List<Map<String, dynamic>> consumablesList =
    //     consumablesJson.map((specificConsumableJson) {
    //   Map<String, dynamic> specificConsumable =
    //       json.decode(specificConsumableJson);
    //   return specificConsumable;
    // }).toList();
    // userConsumables;
    List<Map<String, dynamic>> consumablesList =
        consumablesJson.map((e) => Map<String, dynamic>.from(e)).toList();
    return User(
        key: userJson['key'],
        email: userJson['email'],
        health: userJson['health'],
        maxHealth: userJson['maxHealth'],
        mints: userJson['mints'],
        isSpirit: userJson['isSpirit'],
        mintsWithSpirit: userJson['mintsWithSpirit'],
        consumables: consumablesList,
        mileStone: userJson['mileStone']);
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
      List<Map<String, dynamic>> consumables,
      int mileStone,
      String createdDate}) async {
    this.email = email ?? this.email;
    this.health = health ?? this.health;
    this.maxHealth = maxHealth ?? this.maxHealth;
    this.mints = mints ?? this.mints;
    this.isSpirit = isSpirit ?? this.isSpirit;
    this.mintsWithSpirit = mintsWithSpirit ?? this.mintsWithSpirit;
    this.consumables = consumables ?? this.consumables;
    this.mileStone = mileStone ?? this.mileStone;
    this.lastUpdated = DateTime.now().toString();
    this.createdDate =
        this.createdDate ?? FileUtils.getDateForFileName(DateTime.now());
    await FileUtils.writeUserDetailsToFile(this);
    notifyListeners();
  }

  addConsumable(ConsumablesShopItem shopItem) async {
    if (this.consumables.length == 0) {
      this.consumables = List();
    }
    this.consumables.add(shopItem.insertedObject);
    this.mints -= shopItem.cost;
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
      "consumables": jsonEncode(consumables),
      "mileStone": mileStone,
      "lastUpdated": lastUpdated,
      "createdDate": createdDate
    });
  }
}
