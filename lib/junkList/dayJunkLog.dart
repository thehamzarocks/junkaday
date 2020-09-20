import 'package:junkaday/junkList/SpecificJunkLog.dart';
import 'package:junkaday/user.dart';

class DayJunkLog {
  String key;
  String userEmail;
  String createdDate;
  bool isNoJunkToday;
  List<SpecificJunkLog> logs;
  String lastUpdated;
  User updatedUserDetails;

  DayJunkLog(
      {this.key,
      this.userEmail,
      this.createdDate,
      this.isNoJunkToday,
      this.logs,
      this.lastUpdated,
      this.updatedUserDetails});

  factory DayJunkLog.fromJson(Map<String, dynamic> json) {
    List<dynamic> dayJunkLogsResponse = json['logs'];
    List<SpecificJunkLog> dayJunkLogs = dayJunkLogsResponse
        .map((specificJunkLog) => SpecificJunkLog(
            userEmail: specificJunkLog["user_email"],
            junkItem: specificJunkLog["junkItem"],
            createdTimeStamp: specificJunkLog["createdTimeStamp"]))
        .toList();
    // List<SpecificJunkLog> dayJunkLogs =  dayJunkLogsResponse
    //     .map((specificJunkLog) => SpecificJunkLog.fromJson(specificJunkLog));
    return DayJunkLog(
        key: json['key'],
        userEmail: json['user_email'],
        createdDate: json['createdDate'],
        isNoJunkToday: json['isNoJunkToday'],
        logs: dayJunkLogs,
        lastUpdated: json['lastUpdated'],
        updatedUserDetails: json['updatedUserDetails'] != null ? User.fromJson(json['updatedUserDetails']) : null);
  }
}
