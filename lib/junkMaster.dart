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
    if (!isNoJunkToday && dayJunkLog?.logs?.length == 1) {
      if (!isSpirit) {
        mints += 100;
      }
      // TODO: but this fails for the very first day
      DayJunkLog previousDayLog = await FileUtils.getPreviousDayLog();
      if (previousDayLog == null) {
        health--;
      }
      if (previousDayLog?.logs != null && previousDayLog.logs.length <= 1) {
        health++;
      }
    }

    // reset the isNoJunkToday if it is true
    if (isNoJunkToday == true) {
      isNoJunkToday = false;
      dayJunkLog.updateDayJunkLog(isNoJunkToday: false);
    }

    if (dayJunkLog?.logs?.length == 3) {
      health--;
    }

    if (health >= user.maxHealth) {
      health = user.maxHealth;
    }

    if (health <= 0) {
      isSpirit = true;
      mintsWithSpirit = mints;
      mints = 0;
      health = 1;
    }

    // hmm looks like we aren't preserving isSpirit in a file
    if(isSpirit && health >= 3) {
      isSpirit = false;
      mints = mintsWithSpirit;
      mintsWithSpirit = 0;
    }

    if (mints >= 300) {
      mileStone = 1;
    }

    user.setUserDetails(
        health: health,
        mints: mints,
        isSpirit: isSpirit,
        mintsWithSpirit: mintsWithSpirit,
        mileStone: mileStone);

    // fetch the previous day's file and if it exists and the logs for that day
    // are <= 1, increment health by 1
  }

  // TODO: handle udates one logging no junk also
  static onSpecificJunkAdded(User user, DayJunkLog dayJunkLog) async {
    int mileStone = user.mileStone;
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
