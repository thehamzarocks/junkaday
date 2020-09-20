import 'dart:io';

import 'package:flutter/material.dart';
import 'package:junkaday/authentication/userModel.dart';
import 'package:junkaday/junkList/dayJunkLog.dart';
import 'package:junkaday/junkList/junkConfirmation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:junkaday/junkList/specificJunkLog.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';

class ScrollableJunkList extends StatefulWidget {
  final DayJunkLog dayJunkLog;

  ScrollableJunkList({this.dayJunkLog});
  @override
  _ScrollableJunkListState createState() => _ScrollableJunkListState();
}

class _ScrollableJunkListState extends State<ScrollableJunkList> {
  final List<String> junkUnitsList = [
    "Small/Medium Bag of Chips",
    "A Chocolate Bar",
    "A Slice of cake",
    "A Burger",
    "2 Medium Slices of Pizza",
    "A Regular Bowl of Noodles",
    "250 mils of Coke",
    "Two pieces of fried chicken",
    "A small pack of cookies",
    "Two Jalebis",
    "Two Samosas"
  ];
  bool initialized = false;

  Map<String, Map<String, dynamic>> junkUnitsMap = {
    "chips": {"displayText": "Small/Medium Bag of Chips", "dayCount": 0},
    "chocolateBar": {"displayText": "A Chocolate Bar", "dayCount": 0},
    "cake": {"displayText": "A Slice of cake", "dayCount": 0},
    "cookie": {"displayText": "A small pack of cookies", "dayCount": 0},
  };

  Future<void> _showJunkConfirmationDialog({
    context: BuildContext,
    junkItemKey: String,
    junkItemDisplayText: String,
  }) {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return (JunkConfirmation(
              junkItemKey: junkItemKey,
              junkItemDisplayText: junkItemDisplayText,
              dayJunkLog: widget.dayJunkLog));
        });
  }

  String getCurrentDateForFileName() {
    var now = DateTime.now();
    return "junkLog" +
        "_" +
        now.year.toString() +
        "_" +
        now.month.toString() +
        "_" +
        now.day.toString();
  }

  Future<File> getDayJunkLogFile(fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    final filePath = '$path/$fileName';
    if (FileSystemEntity.typeSync(filePath) == FileSystemEntityType.notFound) {
      return null;
    }
    return File(filePath);
  }

  Future<DayJunkLog> getDayJunkLog(String email) async {
    // if(email == null) {
    //   return null;
    // }
    String currentDateForFileName = getCurrentDateForFileName();
    File dayJunkLogFile = await getDayJunkLogFile(currentDateForFileName);
    if (dayJunkLogFile == null) {
      Provider.of<DayJunkLog>(context).setDayJunkLog(
          userEmail: email, isNoJunkToday: false, logs: <SpecificJunkLog>[]);
      return null;
    }
    String fileContents = await dayJunkLogFile.readAsString();
    DayJunkLog dayJunkLog = DayJunkLog.fromJson(json.decode(fileContents));
    Provider.of<DayJunkLog>(context).setDayJunkLog(
        userEmail: email,
        isNoJunkToday: dayJunkLog.isNoJunkToday,
        logs: dayJunkLog.logs);
    return dayJunkLog;
    // final getResponse = await http
    //     .get('https://inkfb5.deta.dev/dayJunkLog/currentDay/' + email);
    // if (getResponse.statusCode == 200) {
    //   return DayJunkLog.fromJson(json.decode(getResponse.body));
    // }
  }

  void updateJunkList(DayJunkLog dayJunkLog) {
    if (dayJunkLog == null) {
      return;
    }
    junkUnitsMap.forEach((key, value) {
      value["dayCount"] = 0;
    });
    dayJunkLog?.logs?.forEach((specificJunkLog) {
      junkUnitsMap[specificJunkLog.junkItem]["dayCount"]++;
    });
    setState(() {
      junkUnitsMap = junkUnitsMap;
      initialized = true;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<MapEntry<String, Map<String, dynamic>>> junkUnitsMapEntryList =
        junkUnitsMap.entries.toList();
    final String email = Provider.of<UserModel>(context).getUserDetails().email;
    final dayJunkLog = Provider.of<DayJunkLog>(context);
    updateJunkList(dayJunkLog);
    if (!initialized && email != null) {
      getDayJunkLog(email).then((dayJunkLog) {
        // updateJunkList(dayJunkLog);
      });
    }
    return (ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: junkUnitsMapEntryList.length * 2,
        itemBuilder: (context, i) {
          if (i.isOdd) {
            return Divider();
          }
          final index = i ~/ 2;
          return ListTile(
            onTap: () => _showJunkConfirmationDialog(
              context: context,
              junkItemKey: junkUnitsMapEntryList[index].key,
              junkItemDisplayText:
                  junkUnitsMapEntryList[index].value["displayText"],
            ),
            title: Text(junkUnitsMapEntryList[index].value["displayText"]),
            trailing:
                Text(junkUnitsMapEntryList[index].value["dayCount"].toString()),
          );
        }));
  }
}
