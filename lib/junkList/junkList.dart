import 'package:flutter/material.dart';
import 'package:junkaday/errorAlert.dart';
import 'package:junkaday/junkList/dayJunkLog.dart';
import 'package:junkaday/junkList/junkListHelp.dart';
import 'package:junkaday/junkList/scrollableJunkList.dart';
import 'package:junkaday/junkMaster/junkMaster.dart';
import 'package:junkaday/user.dart';
import 'package:provider/provider.dart';

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

  setNoJunkToday(User user, DayJunkLog dayJunkLog) async {
    dayJunkLog.updateDayJunkLog(isNoJunkToday: true);
    JunkMaster.onSpecificJunkAdded(user, dayJunkLog);
    return dayJunkLog;
  }

  _logNoJunkToday(
      BuildContext context, User user, DayJunkLog dayJunkLog) async {
    final String email = Provider.of<User>(context).email;
    if (dayJunkLog?.logs?.length != 0) {
      AlertPopup.showAlert(context, "Already logged junk for today");
      return;
    }
    if (dayJunkLog?.isNoJunkToday == true) {
      AlertPopup.showAlert(context, "Already marked no junk for today");
      return;
    }
    await setNoJunkToday(user, dayJunkLog);

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

  getNoJunkButtonText(DayJunkLog dayJunkLog) {
    if (dayJunkLog?.isNoJunkToday == true) {
      return 'Already Logged No Junk Today!';
    }
    if (dayJunkLog?.logs?.length != 0) {
      return 'Already consumed Junk Today!';
    }
    return 'Log No Junk Today!';
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
                  builder: (context, dayJunkLog, _) => Consumer<User>(
                      builder: (context, user, _) => RaisedButton(
                          onPressed: () =>
                              _logNoJunkToday(context, user, dayJunkLog),
                          color: Theme.of(context).primaryColor,
                          child: Text(getNoJunkButtonText(dayJunkLog)))))),
          Expanded(
              child: Consumer<DayJunkLog>(
                  builder: (context, dayJunkLog, create) =>
                      ScrollableJunkList(dayJunkLog: dayJunkLog)))
        ])));
  }
}
