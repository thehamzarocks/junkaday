import 'package:flutter/material.dart';
import 'package:junkaday/consumables/ConsumablesShopItem.dart';
import 'package:junkaday/consumables/consumable.dart';
import 'package:junkaday/consumables/consumablesShopConfirmationPopup.dart';
import 'package:junkaday/consumables/conusmablesMilestoneMap.dart';

class ConsumablesShop extends StatelessWidget {
  final List<ConsumablesShopItem> consumablesShopItemList = consumablesMilestoneMap[1];

  Future<void> showPurchaseConfirmation(
      BuildContext context, ConsumablesShopItem shopItem) {
    return showDialog(
        context: context,
        builder: (BuildContext context) =>
            ConsumablesShopConfirmationPopup(shopItem: shopItem));
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
          padding: EdgeInsets.all(30.0),
          child: Text(
              'Greetings wanderer! Buy my tinkets so you may remain capable of returning to my shop!')),
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
                            Icon(Icons.miscellaneous_services_outlined),
                            Text(consumablesShopItemList[index].cost.toString())
                          ]),
                          Icon(
                            Icons.shopping_bag,
                            color: Colors.green,
                          )
                        ]));
              }))
    ]);
  }
}
