import 'package:flutter/material.dart';

class AlertPopup extends StatelessWidget {
  final String message;

  AlertPopup({Key key, this.message}) : super(key: key);

  static Future<void> showAlert(BuildContext context, String message) {
    return showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertPopup(message: message);
        });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Alert'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(''),
            Text(message),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Close'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }
}
