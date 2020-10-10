import 'package:flutter/material.dart';
import 'package:junkaday/consumables/ConsumablesShopItem.dart';
import 'package:junkaday/consumables/consumable.dart';

class ConsumablesShop extends StatelessWidget {
  final List<ConsumablesShopItem> consumablesShopItemList = [
    ConsumablesShopItem(
        name: 'Greed',
        description: 'A shiny trinket that reeks of a deadly trait.',
        itemStatsDetails:
            'Gain +200 mints a day but lose 1 health on consuming 2 or 4 units. Lasts three days, shatters in spirit form.',
        cost: 100),
    ConsumablesShopItem(
        name: 'Invincibility',
        description:
            'Wanderers often like to stray from the beaten path. This trinket keeps such fools alive when they do.',
        itemStatsDetails:
            'Keeps you from losing health the next day. Shatters if you enter spirit form before it activates.',
        cost: 300)
  ];

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
                    onTap: () => {},
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
