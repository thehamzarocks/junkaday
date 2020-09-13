import 'package:flutter/material.dart';
import 'package:junkaday/introScreens/introScreens.dart';
import 'package:junkaday/junkList/junkList.dart';
import 'package:junkaday/junkLogger.dart';

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
