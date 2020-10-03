import 'package:flutter/material.dart';

class JunkHelpDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey,
      title: Text('Selecting Junk'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(
                'Pick the item closest to the one you\'ve consumed. Confirm multiple times if you\'ve had multiple units. Or tap the "No Junk Today" button if you aren\'t going to consume any junk today. This can always be overriden by picking an item later. Remember, forgetting to log anything might make you miss out on mints.'),
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
