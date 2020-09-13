import 'package:flutter/material.dart';

class JunkListHelp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      Padding(
          child: Text('What did you consume today?'),
          padding: EdgeInsets.all(16)),
      IconButton(icon: Icon(Icons.help_rounded), onPressed: () => {})
    ]);
  }
}