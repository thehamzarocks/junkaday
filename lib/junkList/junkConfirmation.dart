import 'package:flutter/material.dart';

class JunkConfirmation extends StatelessWidget {
  final String junkItem;

  JunkConfirmation({Key key, this.junkItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Confirm Consumption'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(''),
            Text('Confirm consumption of ' + junkItem + '?'),
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
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
