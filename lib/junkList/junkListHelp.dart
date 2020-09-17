import 'package:flutter/material.dart';
import 'package:junkaday/junkList/junkHelpDialog.dart';

class JunkListHelp extends StatelessWidget {

Future<void> _showJunkHelpDialog(
      {context: BuildContext}) {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return JunkHelpDialog();
        });
  }
  
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      Padding(
          child: Text('What did you consume today?'),
          padding: EdgeInsets.all(16)),
      IconButton(icon: Icon(Icons.help_rounded), onPressed: () => _showJunkHelpDialog(context: context))
    ]);
  }
}