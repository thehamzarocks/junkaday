import 'package:flutter/material.dart';
import 'package:junkaday/junkList/junkConfirmation.dart';

class ScrollableJunkList extends StatelessWidget {
  final List<String> junkUnitsList = [
    "Small/Medium Bag of Chips",
    "A Chocolate Bar",
    "A Slice of cake",
    "A Burger",
    "2 Medium Slices of Pizza",
    "A Regular Bowl of Noodles",
    "250 mils of Coke",
    "Two pieces of fried chicken",
    "A small pack of cookies",
    "Two Jalebis"
  ];

  Future<void> _showJunkConfirmationDialog(
      {context: BuildContext, junkItem: String}) {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return JunkConfirmation(junkItem: junkItem);
        });
  }

  @override
  Widget build(BuildContext context) {
    return (ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: junkUnitsList.length * 2,
        itemBuilder: (context, i) {
          if (i.isOdd) {
            return Divider();
          }
          final index = i ~/ 2;
          return ListTile(
              onTap: () => _showJunkConfirmationDialog(
                  context: context, junkItem: junkUnitsList[index]),
              title: Text(junkUnitsList[index]));
        }));
  }
}
