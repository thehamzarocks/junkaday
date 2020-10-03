import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:junkaday/user.dart';
import 'package:provider/provider.dart';

class Mint extends StatefulWidget {
  int mints = 0;

  @override
  _MintState createState() => _MintState();
}

class _MintState extends State<Mint> {

  final Color _beginColor = Colors.black;
  final Color _mintIncreaseEndColor = Colors.greenAccent;
  final Color _mintDecreaseEndColor = Colors.redAccent;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.mints = 0;
  }

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Row(children: [
        Icon(Icons.miscellaneous_services_outlined),
        Consumer<User>(builder: (context, user, _) {
          if (user.mints != widget.mints) {
            if (widget.mints == null) {
              SchedulerBinding.instance.addPostFrameCallback((_) {
                setState(() {
                  widget.mints = user.mints;
                });
              });
              return Text(widget.mints.toString());
            }
            return TweenAnimationBuilder(
                tween: ColorTween(
                    begin: _beginColor,
                    end: user.mints > widget.mints
                        ? _mintIncreaseEndColor
                        : _mintDecreaseEndColor),
                duration: const Duration(milliseconds: 500),
                onEnd: () {
                  setState(() {
                    widget.mints = user.mints;
                  });
                },
                curve: Curves.elasticInOut,
                builder: (_, Color color, __) {
                  return Text(
                      widget.mints.toString(),
                      style: TextStyle(color: color));
                });
          } else {
            return Text(
                widget.mints.toString());
          }
        })
      ]),
      onPressed: () {
        setState(() {
        });
      },
    );
  }
}
