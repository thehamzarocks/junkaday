import 'package:flutter/material.dart';
import 'package:junkaday/aboutScreen.dart';
import 'package:junkaday/consumables.dart';
import 'package:junkaday/health/health.dart';
import 'package:junkaday/introScreens/introScreens.dart';
import 'package:junkaday/junkList/junkList.dart';
import 'package:junkaday/milestone/milestone.dart';
import 'package:junkaday/mint/mint.dart';
import 'package:junkaday/spirit/spirit.dart';
import 'package:junkaday/testutils.dart';
import 'package:junkaday/user.dart';
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
    // TestUtils(),
    Consumables(),
    IntroScreens(introScreenNumber: 1),
    AboutScreen(),
    Consumables(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final Health health = Health();
  final Mint mint = Mint();
  final MileStone mileStone = MileStone();
  final Spirit spirit = Spirit();

  // TODO: move consumer to the level of frowny and health
  @override
  Widget build(BuildContext context) {
    return (Scaffold(
        appBar: AppBar(
          leading: new Container(),
          actions: [spirit, health, mint, mileStone],
        ),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.list_alt_rounded),
              label: 'List',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.cake_rounded),
              label: 'Consumables',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.help_rounded),
              label: 'Help',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.group_rounded),
              label: 'Friends',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        )));
  }
}
