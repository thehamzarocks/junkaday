import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('JunkADay version 0.1'),
        Text('Initial Release - Single MileStone, No Consumables'),
      ],
    ));
  }
}
