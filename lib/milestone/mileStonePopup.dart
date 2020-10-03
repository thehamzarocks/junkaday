import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MileStonePopup extends StatelessWidget {
  final int mileStoneNumber;

  MileStonePopup({Key key, this.mileStoneNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String mileStoneText = '';
    if (mileStoneNumber == 0) {
      mileStoneText = 'Is there a ... a wanderer?';
    } else if (mileStoneNumber == 1) {
      mileStoneText =
          'Wanderer! Many have ventured through this path, though few have found what they sought. Most return here to the very beginning, often in worse shape. Be wary. Step forth, but step true.';
    }
    return AlertDialog(
      title: Text('Milestone ' + mileStoneNumber.toString()),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(mileStoneText, style: GoogleFonts.roboto()),
            mileStoneNumber == 1
                ? Text(
                    '(Thank you for trying out the beta, more milestones coming soon. Stats locked until next update!')
                : SizedBox.shrink()
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
