import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:junkaday/junkList/DayJunkLog.dart';

class JunkConfirmation extends StatelessWidget {
  final String junkItemKey;
  final String junkItemDisplayText;
  final Function(DayJunkLog) updateJunkLogCallBack;

  JunkConfirmation(
      {Key key,
      this.junkItemKey,
      this.junkItemDisplayText,
      this.updateJunkLogCallBack})
      : super(key: key);

  Future<DayJunkLog> updateDayJunkLog() async {
    final updateResponse = await http.post(
        'https://inkfb5.deta.dev/specificJunkLogs',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "user_email": "test1@test.com",
          "junkItem": junkItemKey
        }));
    if (updateResponse.statusCode == 200) {
      return DayJunkLog.fromJson(json.decode(updateResponse.body));
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
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
            updateDayJunkLog().then((response) {
              updateJunkLogCallBack(response);
            });
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
