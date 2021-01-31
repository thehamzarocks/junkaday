import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:junkaday/milestone/mileStoneTextMap.dart';

class MileStonePopup extends StatelessWidget {
  final int mileStoneNumber;

  MileStonePopup({Key key, this.mileStoneNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String mileStoneText = mileStoneNumber == 0
        ? ''
        : mileStoneTextMap[mileStoneNumber]['mainText'];
    String additionalInfo = mileStoneNumber == 0
        ? ''
        : mileStoneTextMap[mileStoneNumber]['additionalInfo'];

    if (mileStoneNumber == 0) {
      mileStoneText = 'Is there a ... a wanderer?';
    } else if (mileStoneNumber == 1) {
      mileStoneText =
          'Wanderer! Many have ventured through this path, though few have found what they sought. Most return here to the very beginning, often in worse shape. Be wary. Step forth, but step true.';
    }
    return AlertDialog(
      backgroundColor: Colors.grey,
      title: Text('Milestone ' + mileStoneNumber.toString()),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(mileStoneText, style: GoogleFonts.roboto()),
            Text(additionalInfo),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Close'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }
}
