import 'package:flutter/material.dart';

class Health extends StatelessWidget {
  final int health;
  Health({Key key, this.health}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Row(children: [
        Icon(Icons.add),
        Text(health.toString()),
      ]),
      onPressed: () => {},
    );
  }
}
