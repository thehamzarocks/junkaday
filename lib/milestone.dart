import 'package:flutter/material.dart';

class MileStone extends StatelessWidget {
  final int mileStone;
  MileStone({Key key, this.mileStone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Row(children: [
        Icon(Icons.golf_course_rounded),
        Text(" " + mileStone.toString()),
      ]),
      onPressed: () => {},
    );
  }
}
