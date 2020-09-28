import 'package:flutter/material.dart';
import 'package:junkaday/junkList/fileUtils.dart';
import 'package:junkaday/junkList/specificJunkLog.dart';
import 'package:junkaday/user.dart';
import "dart:convert";

class DayJunkLog with ChangeNotifier {
  String key;
  String userEmail;
  String createdDate;
  bool isNoJunkToday;
  List<SpecificJunkLog> logs;
  String lastUpdated;
  User updatedUserDetails;

  void updateDayJunkLog(
      {key,
      userEmail,
      createdDate,
      isNoJunkToday,
      logs,
      lastUpdated,
      updatedUserDetails}) {
    this.key = key ?? this.key;
    this.userEmail = userEmail ?? this.userEmail;
    this.createdDate ??= createdDate ?? this.createdDate;
    this.isNoJunkToday = isNoJunkToday ?? this.isNoJunkToday;
    this.logs = logs ?? this.logs;
    this.lastUpdated = DateTime.now().toString();
    FileUtils.updateCurrentDayJunkLog(this);
    notifyListeners();
  }

  void addSpecificJunkLog(String junkItem) {
    this.logs.add(SpecificJunkLog(junkItem: junkItem));
    notifyListeners();
  }

  void setNoJunkToday() {
    if (this.logs.length != 0) {
      return;
    }
    this.isNoJunkToday = true;
    notifyListeners();
  }

  DayJunkLog(
      {this.key,
      this.userEmail,
      this.createdDate,
      this.isNoJunkToday,
      this.logs,
      this.lastUpdated,
      this.updatedUserDetails});

  factory DayJunkLog.fromJson(Map<String, dynamic> dayJunkLogsJson) {
    String dayJunkLogsResponseString = dayJunkLogsJson['logs'];
    List<dynamic> dayJunkLogsResponseJson =
        json.decode(dayJunkLogsResponseString);
    List<SpecificJunkLog> dayJunkLogs =
        dayJunkLogsResponseJson.map((specificJunkLogJson) {
      Map<String, dynamic> specificJunkLogMap =
          json.decode(specificJunkLogJson);
      SpecificJunkLog specificJunkLog = SpecificJunkLog(
          userEmail: specificJunkLogMap["user_email"],
          junkItem: specificJunkLogMap["junkItem"],
          createdTimeStamp: specificJunkLogMap["createdTimeStamp"]);
      return specificJunkLog;
    }).toList();
    // List<SpecificJunkLog> dayJunkLogs =  dayJunkLogsResponse
    //     .map((specificJunkLog) => SpecificJunkLog.fromJson(specificJunkLog));
    return DayJunkLog(
        key: dayJunkLogsJson['key'],
        userEmail: dayJunkLogsJson['user_email'],
        createdDate: dayJunkLogsJson['createdDate'],
        isNoJunkToday: dayJunkLogsJson['isNoJunkToday'],
        logs: dayJunkLogs,
        lastUpdated: dayJunkLogsJson['lastUpdated'],
        updatedUserDetails: dayJunkLogsJson['updatedUserDetails'] != null
            ? User.fromJson(dayJunkLogsJson['updatedUserDetails'])
            : null);
  }

  void updateSpecificLog(String junkItem) {
    this.logs.add(SpecificJunkLog(
        junkItem: junkItem, userEmail: null, createdTimeStamp: null));
    notifyListeners();
  }

  String toString() {
    List<String> specificJunkLogsList =
        logs.map((specificJunkLog) => specificJunkLog.toString()).toList();
    return json.encode({
      "key": key,
      "userEmail": userEmail,
      "createdDate": createdDate,
      "isNoJunkToday": isNoJunkToday,
      "logs": json.encode(specificJunkLogsList),
      "lastUpdated": lastUpdated
    });
  }
}
