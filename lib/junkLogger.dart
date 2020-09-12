import 'package:flutter/material.dart';
import 'package:junkaday/authentication/auth.dart';

class JunkLogger extends StatefulWidget {
  @override
  _JunkLoggerState createState() => _JunkLoggerState();
}

class _JunkLoggerState extends State<JunkLogger> {
  void handleSignOutAndNavigate(BuildContext buildContext) {
    AuthService.handleSignOut();
  }

  int _junkUnits = 0;

  void _incrementJunkUnits() {
    setState(() => {_junkUnits = _junkUnits + 1});
  }

  void _decrementJunkUnits() {
    if (_junkUnits == 0) {
      return;
    }
    setState(() => {_junkUnits = _junkUnits - 1});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
              child: Text("Units of Junk Consumed:",
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Futura',
                      color: Theme.of(context).primaryColor,
                      decoration: TextDecoration.none)),
              padding: EdgeInsets.all(30.0)),
          Padding(child:Text(
              'Enter the Units of Junk Consumed. If you\'re unsure, refer the junk list and make reasonable assumptions. If you aren\'t going to consume any junk today, simply hit the "No Junk Today" button. You can always override this by logging on the same day.',
              ),
              padding: EdgeInsets.all(30.0)),
          Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                RaisedButton(color: Colors.redAccent,onPressed: _decrementJunkUnits, child: Text('-')),
                Text(_junkUnits.toString()),
                RaisedButton(color: Colors.greenAccent, onPressed: _incrementJunkUnits, child: Text('+')),
              ]),
          RaisedButton(color: Colors.teal[300], onPressed: _incrementJunkUnits, child: Text('Confirm')),
          RaisedButton(
            color: Colors.cyan,
              onPressed: _incrementJunkUnits, child: Text('No Junk Today!')),
          // OutlineButton(
          //     child: Text('Sign Out'),
          //     onPressed: () => handleSignOutAndNavigate(context))
        ]);
  }
}
