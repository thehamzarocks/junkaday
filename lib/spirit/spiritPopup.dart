import 'package:flutter/material.dart';

class SpiritPopup extends StatelessWidget {
  final int mintsWithSpirit;

  SpiritPopup({Key key, this.mintsWithSpirit}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Spirit Form'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(
                'You died, creating a spirit in the world which has all your mints.'),
            Text('Recover them by gaining 3 health and destroying the spirit.'),
            Text(
                'This spirit, and all it\'s mints will be lost forever if you die before destroying it.'),
            Text('Health restored to 1.'),
            Text('Mints with spirit: ' + this.mintsWithSpirit.toString())
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
