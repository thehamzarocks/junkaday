import 'package:junkaday/junkList/dayJunkLog.dart';
import 'package:junkaday/junkList/fileUtils.dart';
import 'package:junkaday/milestone.dart';
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
      }

      DayJunkLog previousDayLog = await FileUtils.getPreviousDayLog();
      // if you forget to log on a day, you lose health, but only once
      if (previousDayLog == null &&
          FileUtils.getDateForFileName(DateTime.now()) != user.createdDate) {
        health--;
      }
      // if you only logged <=1 units the previous day, you gain 1 health
      if (previousDayLog?.logs != null && previousDayLog.logs.length <= 1) {
        health++;
      }
    }

    // reset the isNoJunkToday to false if any junk is logged
    if (isNoJunkToday == true && dayJunkLog?.logs?.length == 1) {
      isNoJunkToday = false;
      dayJunkLog.updateDayJunkLog(isNoJunkToday: false);
    }

    // excessive junk consumption causes you to lose health
    if (dayJunkLog?.logs?.length == 3) {
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

    if (isSpirit && health >= 3) {
      isSpirit = false;
      mints = mintsWithSpirit;
      mintsWithSpirit = 0;
    }

    if (mints >= 300) {
      mileStone = 1;
      mints -= 300;
    }

    user.setUserDetails(
        health: health,
        mints: mints,
        isSpirit: isSpirit,
        mintsWithSpirit: mintsWithSpirit,
        mileStone: mileStone);
  }

  // TODO: handle udates one logging no junk also
  static onSpecificJunkAdded(User user, DayJunkLog dayJunkLog) async {
    int mileStone = user.mileStone;
    mileStone = 0;
    switch (mileStone) {
      case 0:
        handleMileStoneZero(user, dayJunkLog);
        break;
    }
    // decrease health when the total units in a day cross a certain threshold
    // if (true || dayJunkLog?.logs?.length == 39) {
    //   int health = user.health;

    //   await user.setHealth(1);
    // }
  }

  // TODO: check if mints have already been updated for today
  // (is this really called on new days?)
  // static onNewDay(UserModel userModel) {
  //   userModel.setMints(userModel.mints + 100);
  // }
}
