import 'package:flutter/material.dart';
import 'package:junkaday/spirit/spiritPopup.dart';
import 'package:junkaday/user.dart';
import 'package:provider/provider.dart';

class Spirit extends StatefulWidget {
  int isSpirit = 0;

  @override
  _SpiritState createState() => _SpiritState();
}

class _SpiritState extends State<Spirit> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.isSpirit = 0;
  }

  Future<void> _showSpiritPopup(mintsWithSpirit) {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return SpiritPopup(mintsWithSpirit: mintsWithSpirit);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<User>(builder: (context, user, _) {
      if (!user.isSpirit) {
        return SizedBox.shrink();
      } else {
        return FlatButton(
            onPressed: () => _showSpiritPopup(user.mintsWithSpirit),
            child: Icon(Icons.warning_rounded));
      }
    });
  }
}
