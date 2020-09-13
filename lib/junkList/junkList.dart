import 'package:flutter/material.dart';
import 'package:junkaday/junkList/junkListHelp.dart';
import 'package:junkaday/junkList/scrollableJunkList.dart';

class JunkList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      JunkListHelp(),
      Container(
          width: double.infinity,
          padding: EdgeInsets.only(left: 16.0, right: 16.0),
          child: RaisedButton(
              onPressed: () => {},
              color: Theme.of(context).primaryColor,
              child: Text('No Junk Today!'))),
      Expanded(child: ScrollableJunkList())
    ]));
  }
}