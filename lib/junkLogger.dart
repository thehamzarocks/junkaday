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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Text("Log Junk Here!",
          style: TextStyle(
              fontSize: 20,
              fontFamily: 'Futura',
              color: Theme.of(context).primaryColor,
              decoration: TextDecoration.none)),
      OutlineButton(
          child: Text('Sign Out'),
          onPressed: () => handleSignOutAndNavigate(context))
    ]));
  }
}
