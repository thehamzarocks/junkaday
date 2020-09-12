import 'package:flutter/material.dart';

class JunkList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
            children: [JunkListHelp(), Expanded(child: ScrollableJunkList())]));
  }
}

class JunkListHelp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        child: Text(
            'Here\'s what a single unit looks like for different kinds of Junk. Feel free to make your own units for items not on the list, but be consistent!'),
        padding: EdgeInsets.all(16));
  }
}

class ScrollableJunkList extends StatelessWidget {
  final List<String> junkUnitsList = [
    "Small/Medium Bag of Chips",
    "Chocolate Bar",
    "2 Medium Slices of Pizza",
    "A Regular Bowl of Noodles",
    "250 mils of Coke",
    "Two pieces of fried chicken",
    "A small pack of cookies",
    "Two Jalebis"
  ];

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
          return ListTile(title: Text(junkUnitsList[index]));
        }));
  }
}
