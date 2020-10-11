import 'package:flutter/material.dart';
import 'package:junkaday/consumables/ConsumablesShopItem.dart';
import 'package:junkaday/consumables/consumablesShopConfirmationPopup.dart';
import 'package:junkaday/consumables/conusmablesMilestoneMap.dart';
import 'package:junkaday/user.dart';
import 'package:provider/provider.dart';

class ConsumablesShop extends StatelessWidget {
  List<ConsumablesShopItem> consumablesShopItemList;

  Future<void> showPurchaseConfirmation(
      BuildContext context, ConsumablesShopItem shopItem) {
    return showDialog(
        context: context,
        builder: (BuildContext context) =>
            ConsumablesShopConfirmationPopup(shopItem: shopItem));
  }

  Icon getShoppingListIcon(BuildContext context, ConsumablesShopItem shopItem) {
    User user = Provider.of<User>(context);
    int userMints = Provider.of<User>(context).mints;
    IconData iconData;
    Color color = Colors.green;
    if (user.consumables.containsKey(shopItem.name)) {
      iconData = Icons.check;
    } else {
      iconData = Icons.shopping_basket_sharp;
      if (userMints < shopItem.cost) {
        color = Colors.blueGrey;
      }
    }
    return Icon(iconData, color: color);
  }

  @override
  Widget build(BuildContext context) {
    int mileStone = Provider.of<User>(context).mileStone ?? 0;
    consumablesShopItemList = consumablesMilestoneMap[mileStone];
    return Column(children: [
      Padding(
          padding: EdgeInsets.all(30.0),
          child: Text(mileStone != 0
              ? 'Greetings wanderer! Buy my tinkets so you may remain capable of returning to my shop!'
              : 'Hello wanderer! I\'m setting up shop. Why don\'t you come back a bit later?')),
      Expanded(
          child: ListView.builder(
              padding: EdgeInsets.all(16.0),
              itemCount: consumablesShopItemList.length * 2,
              itemBuilder: (context, i) {
                if (i.isOdd) {
                  return Divider();
                }
                final index = i ~/ 2;
                return ListTile(
                    onTap: () => showPurchaseConfirmation(
                        context, consumablesShopItemList[index]),
                    title: Text(consumablesShopItemList[index].name),
                    subtitle: Text(consumablesShopItemList[index].description),
                    isThreeLine: true,
                    // leading: Text(consumablesShopItemList[index].description),
                    trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(mainAxisSize: MainAxisSize.min, children: [
                            Icon(Icons.miscellaneous_services_outlined,
                                color: Colors.black),
                            Text(consumablesShopItemList[index].cost.toString())
                          ]),
                          getShoppingListIcon(
                              context, consumablesShopItemList[index])
                        ]));
              }))
    ]);
  }
}
