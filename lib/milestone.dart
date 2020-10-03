import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:junkaday/user.dart';
import 'package:provider/provider.dart';

class MileStone extends StatefulWidget {
  int mileStones = 0;
  @override
  _MileStoneState createState() => _MileStoneState();
}

class _MileStoneState extends State<MileStone> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.mileStones = 0;
  }

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Row(children: [
        Icon(Icons.golf_course_rounded),
        Consumer<User>(builder: (context, user, _) {
          if (user.mileStone != widget.mileStones) {
            if (widget.mileStones == null) {
              SchedulerBinding.instance.addPostFrameCallback((_) {
                setState(() {
                  widget.mileStones = user.health;
                });
              });
              return Text(widget.mileStones.toString());
            }
            // show popup for milestone
          }
          return Text(widget.mileStones.toString());
        })
      ]),
      onPressed: () {
        setState(() {});
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
