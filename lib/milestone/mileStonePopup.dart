import 'package:flutter/material.dart';

class MileStonePopup extends StatelessWidget {
  final int mileStoneNumber;

  MileStonePopup({Key key, this.mileStoneNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Milestone ' + mileStoneNumber.toString()),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(
                'Wanderer! Many have ventured along this path, though few have found success. Most return here to the very beginning, often in worse shape. Be wary. Step forth, but step true.'),
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
