import 'package:flutter/material.dart';
import 'package:junkaday/authentication/userModel.dart';
import 'package:junkaday/health.dart';
import 'package:junkaday/introScreens/introScreens.dart';
import 'package:junkaday/junkList/junkList.dart';
import 'package:junkaday/milestone.dart';
import 'package:junkaday/mint.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    JunkList(),
    IntroScreens(introScreenNumber: 1),
    JunkList(),
    JunkList(),
  ];

  static List<String> _widgetTitles = ['List', 'Rewards', 'Help', 'Friends'];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // TODO: move consumer to the level of frowny and health
  @override
  Widget build(BuildContext context) {
    return (Scaffold(
        appBar: AppBar(
          actions: [
            Consumer<UserModel>(builder: (context, user, _) {
              if (user.getUserDetails().isSpirit == true) {
                return Icon(Icons.warning_rounded);
              } else {
                return SizedBox.shrink();
              }
            }),
            Consumer<UserModel>(
                builder: (context, user, _) => Health(
                      health: user.getUserDetails().health,
                      maxHealth: user.getUserDetails().maxHealth,
                    )),
            Consumer<UserModel>(
                builder: (context, user, _) =>
                    Mint(mintCount: user.getUserDetails().mints)),
            Consumer<UserModel>(
                builder: (context, user, _) =>
                    MileStone(mileStone: user.getUserDetails().mileStone))
          ],
          title: Text(_widgetTitles.elementAt(_selectedIndex)),
        ),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.list_alt_rounded),
              title: Text('List'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.cake_rounded),
              title: Text('Rewards'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.help_rounded),
              title: Text('Help'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.group_rounded),
              title: Text('Friends'),
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        )));
  }
}
