import 'package:junkaday/junkList/dayJunkLog.dart';
import 'package:junkaday/junkList/fileUtils.dart';
import 'package:junkaday/user.dart';

class JunkMaster {
  // UserModel userModel;
  // DayJunkLog dayJunkLog;

  // JunkMaster(UserModel userModel, DayJunkLog dayJunkLog) {
  //   this.userModel = userModel;
  //   this.dayJunkLog = dayJunkLog;
  // }

  static void handleMileStoneZero(User user, DayJunkLog dayJunkLog) async {
    int health = user.health;
    int mints = user.mints;
    bool isSpirit = user.isSpirit;
    int mintsWithSpirit = user.mintsWithSpirit;
    bool isNoJunkToday = dayJunkLog.isNoJunkToday;
    int mileStone = user.mileStone;

    // the very first log of the day
    if ((isNoJunkToday && dayJunkLog?.logs?.length == 0) ||
        (!isNoJunkToday && dayJunkLog?.logs?.length == 1)) {
      if (!isSpirit) {
        mints += 100;
      } else if (isSpirit) {
        mints += 75;
      }

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

    if (mints >= 300) {
      mileStone = 1;
      mints -= 300;
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
    }
  }
}
