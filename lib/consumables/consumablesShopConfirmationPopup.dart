import 'package:flutter/material.dart';
import 'package:junkaday/consumables/ConsumablesShopItem.dart';
import 'package:junkaday/user.dart';
import 'package:provider/provider.dart';

class ConsumablesShopConfirmationPopup extends StatelessWidget {
  final ConsumablesShopItem shopItem;

  ConsumablesShopConfirmationPopup({this.shopItem});

  Future<void> addConsumable(BuildContext context) {
    User user = Provider.of<User>(context);
    user.addConsumable(this.shopItem);
  }

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
            addConsumable(context);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
