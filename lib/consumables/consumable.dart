import 'package:flutter/material.dart';

class Consumable extends StatelessWidget {
  final String item;
  final String itemDescription = 'A shiny trinket signifying a deadly trait.';
  final String itemStatsDetails = 'Gain +200 mints a day but lose 1 health on consuming 2 or 4 units. Lasts three days, shatters in spirit form.';
  Consumable({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [Text(this.item), Text(this.itemDescription), Text(this.itemStatsDetails)]);
  }
}
