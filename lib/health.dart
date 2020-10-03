import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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
  // TextStyle animateStyle() {
  //   if(widget.health == null) {
  //     return TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black);
  //   }
  //   if(widget.previousHealth == null) {
  //     setState(() {
  //       widget.previousHealth = widget.health;
  //     });
  //     return TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black);
  //   }
  //   if (widget.health > widget.previousHealth) {
  //     setState(() {
  //       widget.previousHealth = widget.health;
  //     });
  //     return TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.yellowAccent);
  //   }
  //   if (widget.health < widget.previousHealth) {
  //     setState(() {
  //       widget.previousHealth = widget.health;
  //     });
  //     return TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.redAccent);
  //   }
  //   if (widget.health == widget.previousHealth) {
  //     return TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black);
  //   }
  // }

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
        setState(() {
        });
      },
    );
  }
}
