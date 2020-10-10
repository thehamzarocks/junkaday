import 'dart:io';

import 'package:flutter/material.dart';
import 'package:junkaday/junkList/dayJunkLog.dart';
import 'package:junkaday/junkMaster/junkMaster.dart';
import 'package:junkaday/user.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';

class JunkConfirmation extends StatelessWidget {
  final String junkItemKey;
  final String junkItemDisplayText;
  final DayJunkLog dayJunkLog;

  JunkConfirmation({
    Key key,
    this.junkItemKey,
    this.junkItemDisplayText,
    this.dayJunkLog,
  }) : super(key: key);

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

  Future<DayJunkLog> updateDayJunkLog(context) async {
    final String email = Provider.of<User>(context).email;
    if (email.isEmpty) {
      return null;
    }
    String currentDateForFileName = getCurrentDateForFileName();
    final Directory directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    final filePath = '$path/$currentDateForFileName';
    File dayJunkLogFile = File(filePath);
    // dayJunkLog.logs.add(SpecificJunkLog(junkItem: junkItemKey));
    dayJunkLog.addSpecificJunkLog(junkItemKey);
    dayJunkLogFile.writeAsStringSync(dayJunkLog.toString());

    // TODO: call the service that handles user stats changes
    // This will read in the user details and junk logs (even from previous days)
    // and update the user stats accordingly
    await JunkMaster.onSpecificJunkAdded(Provider.of<User>(context), dayJunkLog);
    // JunkMaster.onNewDay(Provider.of<UserModel>(context));

    return dayJunkLog;

    // final updateResponse = await http.post(
    //     'https://inkfb5.deta.dev/specificJunkLogs',
    //     headers: <String, String>{
    //       'Content-Type': 'application/json; charset=UTF-8',
    //     },
    //     body: jsonEncode(
    //         <String, String>{"user_email": email, "junkItem": junkItemKey}));
    // if (updateResponse.statusCode == 200) {
    //   return DayJunkLog.fromJson(json.decode(updateResponse.body));
    // }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey,
      title: Text('Confirm Consumption'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(''),
            Text('Confirm consumption of ' + junkItemDisplayText + '?'),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('No'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text('Confirm'),
          onPressed: () {
            updateDayJunkLog(context).then((response) {
            });
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
