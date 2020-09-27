import 'dart:io';

import 'package:flutter/material.dart';
import 'package:junkaday/errorAlert.dart';
import 'package:junkaday/junkList/dayJunkLog.dart';
import 'package:junkaday/junkList/junkListHelp.dart';
import 'package:junkaday/junkList/scrollableJunkList.dart';
import 'package:junkaday/junkList/specificJunkLog.dart';
import 'package:junkaday/user.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class JunkList extends StatelessWidget {
  getCurrentDateForFileName() {
    var now = DateTime.now();
    return "junkLog" +
        "_" +
        now.year.toString() +
        "_" +
        now.month.toString() +
        "_" +
        now.day.toString();
  }

  updateDayJunkLog(BuildContext context, DayJunkLog dayJunkLog) async {
    final String email = Provider.of<User>(context).email;
    if (email.isEmpty) {
      return null;
    }
    String currentDateForFileName = getCurrentDateForFileName();
    final Directory directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    final filePath = '$path/$currentDateForFileName';
    File dayJunkLogFile = File(filePath);
    dayJunkLog.setNoJunkToday();
    dayJunkLogFile.writeAsStringSync(dayJunkLog.toString());
    return dayJunkLog;
  }

  _logNoJunkToday(BuildContext context, DayJunkLog dayJunkLog) async {
    final String email = Provider.of<User>(context).email;
    if (dayJunkLog?.logs?.length != 0) {
      AlertPopup.showAlert(context, "Already logged junk for today");
      return;
    }
    await updateDayJunkLog(context, dayJunkLog);

    // TODO: handle null email and API errors
    // final response = await http
    //     .put("https://inkfb5.deta.dev/dayJunkLog/noJunkToday/" + email);
    // if (response.statusCode == 200) {
    //   AlertPopup.showAlert(context, "Logged no junk for today");
    // } else if (response.statusCode == 401) {
    //   AlertPopup.showAlert(context, "Already logged junk for today");
    // } else {
    //   AlertPopup.showAlert(context, "Error logging no junk for today");
    // }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DayJunkLog>(
        create: (_) => DayJunkLog(),
        child: Scaffold(
            body: Column(children: [
          JunkListHelp(),
          Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 16.0, right: 16.0),
              child: Consumer<DayJunkLog>(
                  builder: (context, dayJunkLog, _) => RaisedButton(
                      onPressed: () => _logNoJunkToday(context, dayJunkLog),
                      color: Theme.of(context).primaryColor,
                      child: dayJunkLog?.logs?.length == 0
                          ? Text('No Junk Today!')
                          : Text('Already Consumed')))),
          Expanded(
              child: Consumer<DayJunkLog>(
                  builder: (context, dayJunkLog, create) =>
                      ScrollableJunkList(dayJunkLog: dayJunkLog)))
        ])));
  }
}
