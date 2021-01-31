import 'package:junkaday/junkList/dayJunkLog.dart';
import 'package:junkaday/junkmaster/junkMaster.dart';
import 'package:junkaday/user.dart';

class MileStone0 {
  static void handleMileStoneZero(User user, DayJunkLog dayJunkLog) async {
    Stats stats = JunkMaster.getStats(user, dayJunkLog);
    await JunkMaster.processFirstLogOfDay(stats, dayJunkLog, user.createdDate, 100, 75);
    await JunkMaster.processNoJunkTodayOverride(stats, dayJunkLog);
    await JunkMaster.processExcessiveJunkConsumption(stats, dayJunkLog);
    await JunkMaster.putHealthInBounds(stats);
    await JunkMaster.processSpirit(stats);
    await JunkMaster.processMileStoneCompletion(stats, 300);
    JunkMaster.updateUserDetails(user, stats);
  }
}