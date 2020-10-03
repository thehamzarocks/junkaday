import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:junkaday/authentication/auth.dart';
import 'package:junkaday/introScreens/introScreenDetails.dart';
import 'package:junkaday/mainPage.dart';
import 'package:junkaday/user.dart';
import 'package:provider/provider.dart';

class IntroScreens extends StatelessWidget {
  IntroScreens({Key key, this.introScreenNumber}) : super(key: key);

  final int introScreenNumber;

  final Map<int, IntroScreenDetails> introScreenMapping = {
    1: IntroScreenDetails(
        1, 'Eating Junk? Embark on an adventure!', Icons.local_pizza_outlined),
    2: IntroScreenDetails(2,
        'Log Units of Junk Consumed and journey through Junkland', Icons.cake),
    3: IntroScreenDetails(
        3, 'Oh, and try not to die.', Icons.fastfood_outlined),
    4: IntroScreenDetails(
        4,
        'Welcome to Junk a Day! Enter units of junk every time you consume them',
        Icons.book_online_outlined),
    5: IntroScreenDetails(
        5,
        'If you don\'t find the item you\'re looking for, make reasonable assumptions',
        Icons.list_outlined),
    6: IntroScreenDetails(
        6,
        'Your health and mints are determined by your habits. So try to be good! And earn milestones!',
        Icons.branding_watermark_outlined),
    7: IntroScreenDetails(
        7,
        'Hit the "No Junk Today" button if you\'re not going to have any today. You can always override this by entering units later. Don\'t forget to log daily!',
        Icons.not_interested),
    8: IntroScreenDetails(
        8,
        'That\'s it! Obtain milestones while keeping your health up, and have fun!',
        Icons.favorite_outline_outlined),
  };

  void _navigate(BuildContext context) {
    int nextIntroScreen = 0;
    if (introScreenNumber <= 3) {
      nextIntroScreen = (introScreenNumber - 1 + 1) % 3 + 1;
    } else if (introScreenNumber <= 7) {
      nextIntroScreen = introScreenNumber + 1;
    }

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => nextIntroScreen == 0
                ? MainPage()
                : IntroScreens(introScreenNumber: nextIntroScreen)));
  }

  void signInAndNavigate(BuildContext context) {
    AuthService.handleSignIn().then((account) =>
        AuthService.getUserDetails(account.email).then((value) {
          Provider.of<User>(context, listen: false).setUserDetails(
              email: value.email,
              health: value.health,
              maxHealth: value.maxHealth,
              mints: value.mints,
              isSpirit: value.isSpirit,
              mileStone: value.mileStone);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => IntroScreens(introScreenNumber: 4)));
        }));
  }

  @override
  Widget build(BuildContext context) {
    IntroScreenDetails currentIntroScreenDetails =
        introScreenMapping[introScreenNumber];
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: GestureDetector(
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
                          ? (GoogleSignInButton(
                              onPressed: () =>
                                  signInAndNavigate(context) /* ... */,
                              darkMode: true, // default: false
                            ))
                          : SizedBox.shrink())
                    ]))));
  }
}
