import 'package:junkaday/junkList/dayJunkLog.dart';
import 'package:junkaday/junkList/fileUtils.dart';
import 'package:junkaday/junkmaster/junkMaster.dart';
import 'package:junkaday/user.dart';

class MileStone1 {
  static Future<void> processFirstLogOfDay(
      Stats stats,
      DayJunkLog dayJunkLog,
      String userCreatedDate,
      int normalMintsIncrease,
      int spiritMintsIncrease) async {
    // the very first log of the day
    if ((stats.isNoJunkToday && dayJunkLog?.logs?.length == 0) ||
        (!stats.isNoJunkToday && dayJunkLog?.logs?.length == 1)) {
      if (!stats.isSpirit) {
        List<String> consumablesList =
            stats.consumables.map((e) => e['name']).toList();
        stats.consumables.removeWhere((element) =>
            element['name'] == 'Invincibility' && element['activated'] == true);
        if (consumablesList.contains('Greed')) {
          stats.mints += 200;
          stats.consumables.map((e) {
            if (e['name'] == 'Greed') {
              e['daysUsed']++;
            }
            return e;
          }).toList();
          stats.consumables.removeWhere((element) =>
              element['name'] == 'Greed' && element['daysUsed'] == 3);
        } else {
          stats.mints += normalMintsIncrease;
        }
      } else if (stats.isSpirit) {
        stats.mints += spiritMintsIncrease;
      }

      DayJunkLog previousDayLog = await FileUtils.getPreviousDayLog();
      // if you forget to log on a day, you lose health, but only once
      if (previousDayLog == null &&
          FileUtils.getDateForFileName(DateTime.now()) != userCreatedDate) {
        List<String> consumablesList =
            stats.consumables.map((e) => e['name']).toList();
        if (!consumablesList.contains('Invincibility')) {
          stats.health--;
        }
      }
      // if you only logged <=2 units the previous day, you gain 1 health
      if (previousDayLog?.logs != null && previousDayLog.logs.length <= 2) {
        stats.health++;
      }
    }
  }

  static Future<void> processExcessiveJunkConsumption(
      Stats stats, DayJunkLog dayJunkLog) async {
    List<String> consumablesList =
        stats.consumables.map((e) => e['name']).toList();
    if (!consumablesList.contains('Invincibility')) {
      return;
    }
    // excessive junk consumption causes you to lose health
    if (dayJunkLog?.logs?.length == 3 || dayJunkLog?.logs?.length == 6) {
      stats.health--;
    }
  }

  static void handleMileStoneOne(User user, DayJunkLog dayJunkLog) async {
    Stats stats = JunkMaster.getStats(user, dayJunkLog);
    // TODO: add greed modifiers
    await processFirstLogOfDay(stats, dayJunkLog, user.createdDate, 100, 75);
    List<String> consumablesList = stats.consumables.map((e) => e['name']);
    if (consumablesList.contains('Invincibility')) {
      stats.consumables.map((e) {
        if (e['name'] == 'Invincibility') {
          e['activated'] = true;
        }
        return e;
      }).toList();
    }
    await JunkMaster.processNoJunkTodayOverride(stats, dayJunkLog);
    await JunkMaster.processExcessiveJunkConsumption(stats, dayJunkLog);
    await JunkMaster.putHealthInBounds(stats);
    await JunkMaster.processSpirit(stats);
    await JunkMaster.processMileStoneCompletion(stats, 700);
    JunkMaster.updateUserDetails(user, stats);
  }
}
