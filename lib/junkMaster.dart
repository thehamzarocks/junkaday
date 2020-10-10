import 'package:junkaday/junkList/dayJunkLog.dart';
import 'package:junkaday/junkList/fileUtils.dart';
import 'package:junkaday/user.dart';

class Stats {
  int health;
  int maxHealth;
  int mints;
  bool isSpirit;
  int mintsWithSpirit;
  bool isNoJunkToday;
  int mileStone;

  Stats(
      {this.health,
      this.maxHealth,
      this.mints,
      this.isSpirit,
      this.mintsWithSpirit,
      this.isNoJunkToday,
      this.mileStone});
}

class JunkMaster {
  // UserModel userModel;
  // DayJunkLog dayJunkLog;

  // JunkMaster(UserModel userModel, DayJunkLog dayJunkLog) {
  //   this.userModel = userModel;
  //   this.dayJunkLog = dayJunkLog;
  // }

  static Future<void> processFirstLogOfDay(
      Stats stats, DayJunkLog dayJunkLog, String userCreatedDate) async {
    // the very first log of the day
    if ((stats.isNoJunkToday && dayJunkLog?.logs?.length == 0) ||
        (!stats.isNoJunkToday && dayJunkLog?.logs?.length == 1)) {
      if (!stats.isSpirit) {
        stats.mints += 100;
      } else if (stats.isSpirit) {
        stats.mints += 75;
      }

      DayJunkLog previousDayLog = await FileUtils.getPreviousDayLog();
      // if you forget to log on a day, you lose health, but only once
      if (previousDayLog == null &&
          FileUtils.getDateForFileName(DateTime.now()) != userCreatedDate) {
        stats.health--;
      }
      // if you only logged <=2 units the previous day, you gain 1 health
      if (previousDayLog?.logs != null && previousDayLog.logs.length <= 2) {
        stats.health++;
      }
    }
  }

  static Future<void> processNoJunkTodayOverride(
      Stats stats, DayJunkLog dayJunkLog) async {
    // reset the isNoJunkToday to false if any junk is logged
    if (stats.isNoJunkToday == true && dayJunkLog?.logs?.length == 1) {
      stats.isNoJunkToday = false;
      dayJunkLog.updateDayJunkLog(isNoJunkToday: false);
    }
  }

  static Future<void> processExcessiveJunkConsumption(
      Stats stats, DayJunkLog dayJunkLog) async {
    // excessive junk consumption causes you to lose health
    if (dayJunkLog?.logs?.length == 3 || dayJunkLog?.logs?.length == 6) {
      stats.health--;
    }
  }

  static Future<void> putHealthInBounds(Stats stats) async {
    if (stats.health > stats.maxHealth) {
      stats.health = stats.maxHealth;
    }
    if (stats.health < 0) {
      stats.health = 0;
    }
  }

  static Future<void> processSpirit(Stats stats) async {
    // if you die, you enter spirit form and respawn at 1 health
    // all your mints belong to the spirit now
    // needless to say, if you had mints with a previous spirit, they're lost forever
    if (stats.health <= 0) {
      stats.isSpirit = true;
      stats.mintsWithSpirit = stats.mints;
      stats.mints = 0;
      stats.health = 1;
    }

    // recover your mints from the spirit
    if (stats.isSpirit && stats.health >= 3) {
      stats.isSpirit = false;
      stats.mints += stats.mintsWithSpirit;
      stats.mintsWithSpirit = 0;
    }
  }

  static Future<void> processMileStoneCompletion(Stats stats) async {
    if (stats.mints >= 300) {
      stats.mileStone = 1;
      stats.mints -= 300;
    }
  }

  static Stats getStats(User user, DayJunkLog dayJunkLog) {
    return new Stats(
        health: user.health,
        maxHealth: user.maxHealth,
        mints: user.mints,
        isSpirit: user.isSpirit,
        mintsWithSpirit: user.mintsWithSpirit,
        isNoJunkToday: dayJunkLog.isNoJunkToday,
        mileStone: user.mileStone);
  }

  static void handleMileStoneZero(User user, DayJunkLog dayJunkLog) async {

    Stats stats = getStats(user, dayJunkLog);

    await processFirstLogOfDay(stats, dayJunkLog, user.createdDate);
    await processNoJunkTodayOverride(stats, dayJunkLog);
    await processExcessiveJunkConsumption(stats, dayJunkLog);
    await putHealthInBounds(stats);
    await processSpirit(stats);
    await processMileStoneCompletion(stats);

    user.setUserDetails(
        health: stats.health,
        maxHealth: user.maxHealth,
        mints: stats.mints,
        isSpirit: stats.isSpirit,
        mintsWithSpirit: stats.mintsWithSpirit,
        mileStone: stats.mileStone);
    
  }

  static changeOnlyHealth(User user, DayJunkLog dayJunkLog) async {
    int health = user.health;
    int mints = user.mints;
    bool isSpirit = user.isSpirit;
    int mintsWithSpirit = user.mintsWithSpirit;
    bool isNoJunkToday = dayJunkLog.isNoJunkToday;
    int mileStone = user.mileStone;

    if ((isNoJunkToday && dayJunkLog?.logs?.length == 0) ||
        (!isNoJunkToday && dayJunkLog?.logs?.length == 1)) {
      DayJunkLog previousDayLog = await FileUtils.getPreviousDayLog();
      // if you forget to log on a day, you lose health, but only once
      if (previousDayLog == null &&
          FileUtils.getDateForFileName(DateTime.now()) != user.createdDate) {
        health--;
      }
      // if you only logged <=2 units the previous day, you gain 1 health
      if (previousDayLog?.logs != null && previousDayLog.logs.length <= 2) {
        health++;
      }
    }

    // reset the isNoJunkToday to false if any junk is logged
    if (isNoJunkToday == true && dayJunkLog?.logs?.length == 1) {
      isNoJunkToday = false;
      dayJunkLog.updateDayJunkLog(isNoJunkToday: false);
    }

    // excessive junk consumption causes you to lose health
    if (dayJunkLog?.logs?.length == 3 || dayJunkLog?.logs?.length == 6) {
      health--;
    }

    if (health >= user.maxHealth) {
      health = user.maxHealth;
    }

    // if you die, you enter spirit form and respawn at 1 health
    // all your mints belong to the spirit now
    // needless to say, if you had mints with a previous spirit, they're lost forever
    if (health <= 0) {
      isSpirit = true;
      mintsWithSpirit = mints;
      mints = 0;
      health = 1;
    }

    // recover your mints from the spirit
    if (isSpirit && health >= 3) {
      isSpirit = false;
      mints += mintsWithSpirit;
      mintsWithSpirit = 0;
    }

    user.setUserDetails(
        health: health,
        maxHealth: 4,
        mints: mints,
        isSpirit: isSpirit,
        mintsWithSpirit: mintsWithSpirit,
        mileStone: mileStone);
  }

  // TODO: handle udates one logging no junk also
  static onSpecificJunkAdded(User user, DayJunkLog dayJunkLog) async {
    int mileStone = user.mileStone;
    switch (mileStone) {
      case 0:
        handleMileStoneZero(user, dayJunkLog);
        break;
      case 1:
        changeOnlyHealth(user, dayJunkLog);
    }
  }
}
