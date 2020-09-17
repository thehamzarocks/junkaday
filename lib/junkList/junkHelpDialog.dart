import 'package:flutter/material.dart';

class JunkHelpDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Selecting Junk'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(
                'Pick the item closest to the one you\'ve consumed. Confirm multiple times if you\'ve had multiple units. Or tap the "No Junk Today" button if you aren\'t going to consume any junk today. This can always be overriden by picking an item later. Remember, forgetting to log anything might result in frownys.'),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Ok'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
