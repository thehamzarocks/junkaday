import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:junkaday/milestone/mileStonePopup.dart';

import 'package:junkaday/user.dart';
import 'package:provider/provider.dart';

class MileStone extends StatefulWidget {
  int mileStones;
  @override
  _MileStoneState createState() => _MileStoneState();
}

class _MileStoneState extends State<MileStone> {
  Future<void> _showMileStone({mileStoneNumber: String}) {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return MileStonePopup(mileStoneNumber: mileStoneNumber);
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Row(children: [
        Icon(Icons.golf_course_rounded),
        Consumer<User>(builder: (context, user, _) {
          if (user.mileStone != widget.mileStones) {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              if (widget.mileStones != null) {
                _showMileStone(mileStoneNumber: user.mileStone);
              }
              setState(() {
                widget.mileStones = user.mileStone;
              });
            });
          }
          return Text(widget.mileStones.toString());
        })
      ]),
      onPressed: () {
        _showMileStone(mileStoneNumber: widget.mileStones);
      },
    );
  }
}

// import 'package:flutter/material.dart';

// class MileStone extends StatelessWidget {
//   final int mileStone;
//   MileStone({Key key, this.mileStone}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return FlatButton(
//       child: Row(children: [
//         Icon(Icons.golf_course_rounded),
//         Text(" " + mileStone.toString()),
//       ]),
//       onPressed: () => {},
//     );
//   }
// }
