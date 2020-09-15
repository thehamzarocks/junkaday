import 'package:flutter/material.dart';

class Frowny extends StatelessWidget {
  final int frownyCount;
  Frowny({Key key, this.frownyCount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Row(children: [
        Text(':( ' + frownyCount.toString()),
      ]),
      onPressed: () => {},
    );
  }
}
