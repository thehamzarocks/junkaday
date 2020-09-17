import 'package:flutter/material.dart';
import 'package:junkaday/junkList/DayJunkLog.dart';
import 'package:junkaday/junkList/junkConfirmation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ScrollableJunkList extends StatefulWidget {
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
          return JunkConfirmation(
              junkItemKey: junkItemKey,
              junkItemDisplayText: junkItemDisplayText,
              updateJunkLogCallBack: updateJunkList);
        });
  }

  Future<DayJunkLog> getDayJunkLog() async {
    final getResponse = await http
        .get('https://inkfb5.deta.dev/dayJunkLog/currentDay/test1@test.com');
    if (getResponse.statusCode == 200) {
      return DayJunkLog.fromJson(json.decode(getResponse.body));
    }
  }

  void updateJunkList(DayJunkLog dayJunkLog) {
    junkUnitsMap.forEach((key, value) {
      value["dayCount"] = 0;
    });
    dayJunkLog.logs.forEach((specificJunkLog) {
      junkUnitsMap[specificJunkLog.junkItem]["dayCount"]++;
    });
    setState(() {
      junkUnitsMap = junkUnitsMap;
    });
  }

  // TODO: put in safety checks for when the key from the response is not present in the map
  @override
  void initState() {
    super.initState();
    getDayJunkLog().then((dayJunkLog) {
      updateJunkList(dayJunkLog);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<MapEntry<String, Map<String, dynamic>>> junkUnitsMapEntryList =
        junkUnitsMap.entries.toList();
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
                    junkUnitsMapEntryList[index].value["displayText"]),
            title: Text(junkUnitsMapEntryList[index].value["displayText"]),
            trailing:
                Text(junkUnitsMapEntryList[index].value["dayCount"].toString()),
          );
        }));
  }
}
