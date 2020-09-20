import 'package:flutter/material.dart';
import 'package:junkaday/authentication/userModel.dart';
import 'package:junkaday/errorAlert.dart';
import 'package:junkaday/junkList/dayJunkLog.dart';
import 'package:junkaday/junkList/junkListHelp.dart';
import 'package:junkaday/junkList/scrollableJunkList.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class JunkList extends StatelessWidget {
  _logNoJunkToday(BuildContext context) async {
    final String email = Provider.of<UserModel>(context).getUserDetails().email;
    // TODO: handle null email and API errors
    final response = await http
        .put("https://inkfb5.deta.dev/dayJunkLog/noJunkToday/" + email);
    if (response.statusCode == 200) {
      AlertPopup.showAlert(context, "Logged no junk for today");
    } else if (response.statusCode == 401) {
      AlertPopup.showAlert(context, "Already logged junk for today");
    } else {
      AlertPopup.showAlert(context, "Error logging no junk for today");
    }
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
              child: RaisedButton(
                  onPressed: () => _logNoJunkToday(context),
                  color: Theme.of(context).primaryColor,
                  child: Text('No Junk Today!'))),
          Expanded(child: Consumer<DayJunkLog>(builder: (context, dayJunkLog, create) => ScrollableJunkList(dayJunkLog: dayJunkLog)))
        ])));
  }
}
