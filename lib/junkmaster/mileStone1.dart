import 'package:junkaday/junkList/dayJunkLog.dart';
import 'package:junkaday/junkmaster/junkMaster.dart';
import 'package:junkaday/user.dart';

class MileStone1 {
  static void handleMileStoneOne(User user, DayJunkLog dayJunkLog) async {
    Stats stats = JunkMaster.getStats(user, dayJunkLog);
    // TODO: add greed modifiers
    await JunkMaster.processFirstLogOfDay(stats, dayJunkLog, user.createdDate, 100, 75);
    await JunkMaster.processNoJunkTodayOverride(stats, dayJunkLog);
    await JunkMaster.processExcessiveJunkConsumption(stats, dayJunkLog);
    await JunkMaster.putHealthInBounds(stats);
    await JunkMaster.processSpirit(stats);
    await JunkMaster.processMileStoneCompletion(stats, 700);
    JunkMaster.updateUserDetails(user, stats);
  }
}