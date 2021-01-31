import 'package:flutter/material.dart';
import 'package:junkaday/consumables/ConsumablesShopItem.dart';
import 'package:junkaday/user.dart';
import 'package:provider/provider.dart';

class ConsumablesShopConfirmationPopup extends StatelessWidget {
  final ConsumablesShopItem shopItem;

  ConsumablesShopConfirmationPopup({this.shopItem});

  Future<void> addConsumable(BuildContext context) async {
    User user = Provider.of<User>(context);
    await user.addConsumable(this.shopItem);
  }

  bool alreadyHasConsumable(BuildContext context) {
    User user = Provider.of<User>(context);
    return user.consumables.containsKey(this.shopItem.name);
  }

  @override
  Widget build(BuildContext context) {
    int mints = Provider.of<User>(context).mints;
    if (mints >= this.shopItem.cost && ! alreadyHasConsumable(context)) {
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
    } else if (alreadyHasConsumable(context)) {
      return AlertDialog(
        backgroundColor: Colors.grey,
        title: Text('Already Own Consumable'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(shopItem.itemStatsDetails),
              Text(
                  'These trinkets are hard to come by, I can only let you have one of each.'),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Leave'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    } else {
      return AlertDialog(
        backgroundColor: Colors.grey,
        title: Text('Not Enough Mints'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(shopItem.itemStatsDetails),
              Text(
                  'Ooh, looks like you don\'t have enough mints! Do check back when you do.'),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Leave'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    }
  }
}
