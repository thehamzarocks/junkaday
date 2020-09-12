// Flutter code sample for BottomNavigationBar

// This example shows a [BottomNavigationBar] as it is used within a [Scaffold]
// widget. The [BottomNavigationBar] has three [BottomNavigationBarItem]
// widgets and the [currentIndex] is set to index 0. The selected item is
// amber. The `_onItemTapped` function changes the selected item's index
// and displays a corresponding message in the center of the [Scaffold].
//
// ![A scaffold with a bottom navigation bar containing three bottom navigation
// bar items. The first one is selected.](https://flutter.github.io/assets-for-api-docs/assets/material/bottom_navigation_bar.png)

import 'package:flutter/material.dart';
import 'package:junkaday/introScreens/introScreens.dart';
import 'package:junkaday/junkList.dart';
import 'package:junkaday/junkLogger.dart';
import 'package:junkaday/main.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    JunkLogger(),
    JunkList(),
    IntroScreens( introScreenNumber: 1),
    JunkList(),
    JunkList(),
  ];

  static List<String> _widgetTitles = [
    'Logger',
    'List',
    'Rewards',
    'Help',
    'Friends'
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(icon: Icon(Icons.cake_rounded), onPressed: ()=>{})],
        title: Text(_widgetTitles.elementAt(_selectedIndex)),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_rounded),
            title: Text('Logger'),
          ),
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
      ),
    );
  }
}
