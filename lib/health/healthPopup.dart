import 'package:flutter/material.dart';

class HealthPopup extends StatelessWidget {
  final int health;
  final int maxHealth;

  HealthPopup({Key key, this.health, this.maxHealth}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:
          Text('Health: ' + health.toString() + ' / ' + maxHealth.toString()),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text('Consume <= 2 units in a day to get +1 Health the next day'),
            Text('Consume 3 units in a day to lose -1 Health'),
            Text('Consume 6 units in a day to lose -1 Health'),
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
