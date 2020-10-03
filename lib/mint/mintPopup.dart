import 'package:flutter/material.dart';

class MintPopup extends StatelessWidget {
  final int mints;

  MintPopup({Key key, this.mints}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey,
      title: Text('Mints: ' + mints.toString()),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text('Log anything on a day to gain +100 mints'),
            Text('Spirit form reduces mints gained per day to +75'),
            Text('Acquire 300 mints to reach the Milestone 1'),
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
