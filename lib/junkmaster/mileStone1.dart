import 'package:junkaday/junkList/dayJunkLog.dart';
import 'package:junkaday/junkList/fileUtils.dart';
import 'package:junkaday/junkmaster/junkMaster.dart';
import 'package:junkaday/user.dart';

class MileStone1 {
  static void destroyInvincibilityConsumableIfExpired(Stats stats) {
    if (!stats.consumables.containsKey('Invincibility')) {
      return;
    }
    Map<String, dynamic> invincibilityConsumable =
        stats.consumables['Invincibility'];
    if (invincibilityConsumable['activated']) {
      stats.consumables.remove('Invincibility');
    }
  }

  static Future<void> processFirstLogOfDay(
      Stats stats,
      DayJunkLog dayJunkLog,
      String userCreatedDate,
      int normalMintsIncrease,
      int spiritMintsIncrease) async {
    // the very first log of the day
    if ((stats.isNoJunkToday && dayJunkLog?.logs?.length == 0) ||
        (!stats.isNoJunkToday && dayJunkLog?.logs?.length == 1)) {
      destroyInvincibilityConsumableIfExpired(stats);
      if (!stats.isSpirit) {
        if (stats.consumables.containsKey('Greed')) {
          normalMintsIncrease = 200;
          stats.consumables['Greed']['daysUsed']++;
          if (stats.consumables['Greed']['daysUsed'] == 3) {
            stats.consumables.remove('Greed');
          }
        }
        stats.mints += normalMintsIncrease;
      } else if (stats.isSpirit) {
        stats.mints += spiritMintsIncrease;
      }

      DayJunkLog previousDayLog = await FileUtils.getPreviousDayLog();
      // if you forget to log on a day, you lose health, but only once
      if (previousDayLog == null &&
          FileUtils.getDateForFileName(DateTime.now()) != userCreatedDate) {
        if (!stats.consumables.containsKey('Invincibility')) {
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
    if (stats.consumables.containsKey('Invincibility')) {
      return;
    }
    // excessive junk consumption causes you to lose health
    if (dayJunkLog?.logs?.length == 3 || dayJunkLog?.logs?.length == 6) {
      stats.health--;
    }
  }

  static void activateInvincibilityConsumable(Stats stats) {
    if(stats.consumables.containsKey('Invincibility')) {
      stats.consumables['Invincibility']['activated'] = true;
    }
  }

  static void handleMileStoneOne(User user, DayJunkLog dayJunkLog) async {
    Stats stats = JunkMaster.getStats(user, dayJunkLog);
    await processFirstLogOfDay(stats, dayJunkLog, user.createdDate, 100, 75);
    activateInvincibilityConsumable(stats);
    await JunkMaster.processNoJunkTodayOverride(stats, dayJunkLog);
    await processExcessiveJunkConsumption(stats, dayJunkLog);
    await JunkMaster.putHealthInBounds(stats);
    await JunkMaster.processSpirit(stats);
    await JunkMaster.processMileStoneCompletion(stats, 700);
    JunkMaster.updateUserDetails(user, stats);
  }
}
