import 'package:flutter/material.dart';

class Health extends StatelessWidget {
  final int health;
  final int maxHealth;
  Health({Key key, this.health, this.maxHealth}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Row(children: [
        Icon(Icons.add),
        Text(health.toString() + " / " + maxHealth.toString()),
      ]),
      onPressed: () => {},
    );
  }
}
