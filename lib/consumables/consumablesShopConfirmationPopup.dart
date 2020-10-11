import 'package:flutter/material.dart';
import 'package:junkaday/consumables/ConsumablesShopItem.dart';

class ConsumablesShopConfirmationPopup extends StatelessWidget {
  final ConsumablesShopItem shopItem;

  ConsumablesShopConfirmationPopup({this.shopItem});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey,
      title: Text('Confirm Purchase'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(shopItem.itemStatsDetails),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('No Thanks'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text('Confirm Purchase'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
