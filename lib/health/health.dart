import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:junkaday/health/healthPopup.dart';
import 'package:junkaday/milestone/mileStonePopup.dart';
import 'package:junkaday/milestone/milestone.dart';
import 'package:junkaday/user.dart';
import 'package:provider/provider.dart';

class Health extends StatefulWidget {
  int health = 0;
  int maxHealth = 0;
  // Health({Key key, this.health, this.maxHealth}) : super(key: key);

  @override
  _HealthState createState() => _HealthState();
}

class _HealthState extends State<Health> {
  final Color _beginColor = Colors.black;
  final Color _healthIncreaseEndColor = Colors.greenAccent;
  final Color _healthDecreaseEndColor = Colors.redAccent;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.health = 0;
    widget.maxHealth = 0;
  }

  Future<void> _showHealthPopup() {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return HealthPopup(
              health: widget.health, maxHealth: widget.maxHealth);
        });
  }

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Row(children: [
        Icon(Icons.add),
        Consumer<User>(builder: (context, user, _) {
          if (user.health != widget.health) {
            if (widget.health == null) {
              SchedulerBinding.instance.addPostFrameCallback((_) {
                setState(() {
                  widget.health = user.health;
                  widget.maxHealth = user.maxHealth;
                });
              });
              return Text(widget.health.toString() +
                  " / " +
                  widget.maxHealth.toString());
            }
            return TweenAnimationBuilder(
                tween: ColorTween(
                    begin: _beginColor,
                    end: user.health > widget.health
                        ? _healthIncreaseEndColor
                        : _healthDecreaseEndColor),
                duration: const Duration(milliseconds: 500),
                onEnd: () {
                  setState(() {
                    widget.health = user.health;
                    widget.maxHealth = user.maxHealth;
                  });
                },
                curve: Curves.elasticInOut,
                builder: (_, Color color, __) {
                  return Text(
                      widget.health.toString() +
                          " / " +
                          widget.maxHealth.toString(),
                      style: TextStyle(color: color));
                });
          } else {
            return Text(
                widget.health.toString() + " / " + widget.maxHealth.toString());
          }
        })
      ]),
      onPressed: () {
        _showHealthPopup();
      },
    );
  }
}
