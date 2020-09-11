import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:junkaday/authentication/auth.dart';
import 'package:junkaday/introScreens/introScreenDetails.dart';
import 'package:junkaday/junkLogger.dart';

class IntroScreens extends StatelessWidget {
  IntroScreens({Key key, this.introScreenNumber}) : super(key: key);

  final int introScreenNumber;

  final Map<int, IntroScreenDetails> introScreenMapping = {
    1: IntroScreenDetails(
        1, 'Eating Junk? Don\'t be shy about it', Icons.local_pizza_outlined),
    2: IntroScreenDetails(
        2, 'Log Units of Junk Consumed, and Earn Quirky Rewards', Icons.cake),
    3: IntroScreenDetails(
        3,
        'Check on your Friends, try not to have the most Frownys',
        Icons.fastfood_outlined),
  };

  void _navigate(BuildContext context) {
    final int nextIntroScreen = (introScreenNumber) % 3 + 1;
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                IntroScreens(introScreenNumber: nextIntroScreen)));
  }

  void signInAndNavigate(BuildContext context) {
    AuthService.handleSignIn().then((value) => 
      Navigator.push(
        context, MaterialPageRoute(builder: (context) => JunkLogger())));
  }

  @override
  Widget build(BuildContext context) {
    IntroScreenDetails currentIntroScreenDetails =
        introScreenMapping[introScreenNumber];
    return Scaffold(
        backgroundColor: Colors.white,
        body: GestureDetector(
            onTap: () => _navigate(context),
            child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  (Padding(
                      child: Icon(currentIntroScreenDetails.icon,
                          color: Theme.of(context).primaryColor, size: 200),
                      padding: EdgeInsets.all(30.0))),
                  (Padding(
                      padding: EdgeInsets.all(30.0),
                      child: (Text(currentIntroScreenDetails.text,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Futura',
                              color: Theme.of(context).primaryColor,
                              decoration: TextDecoration.none))))),
                  (introScreenNumber == 3
                      ? GoogleSignInButton(
                          onPressed: () => signInAndNavigate(context) /* ... */,
                          darkMode: true, // default: false
                        )
                      : SizedBox.shrink())
                ])));
  }
}
