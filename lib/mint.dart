import 'package:flutter/material.dart';

class Mint extends StatelessWidget {
  final int mintCount;
  Mint({Key key, this.mintCount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Row(children: [
        Icon(Icons.add_circle_outline_rounded),
        Text(" " + mintCount.toString()),
      ]),
      onPressed: () => {},
    );
  }
}
