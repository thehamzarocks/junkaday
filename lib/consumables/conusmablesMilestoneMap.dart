import 'package:junkaday/consumables/ConsumablesShopItem.dart';

final Map<int, List<ConsumablesShopItem>> consumablesMilestoneMap = {
  0: [],
  1: [
    ConsumablesShopItem(
        name: 'Greed',
        description: 'A shiny trinket that reeks of a deadly trait.',
        itemStatsDetails:
            'Gain +200 mints a day but lose 1 health on consuming 2 or 4 units. Applies to the next three first logs of the day, shatters in spirit form.',
        cost: 100,
        insertedObject: {"name": 'Greed', 'daysUsed': 0}),
    ConsumablesShopItem(
        name: 'Invincibility',
        description:
            'Wanderers often like to stray from the beaten path. This trinket keeps such fools alive when they do.',
        itemStatsDetails: 'Keeps you from losing any health today.',
        cost: 300,
        insertedObject: {"name": 'Invincibility', "activated": false}),
  ],
};
