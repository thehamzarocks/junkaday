import 'package:junkaday/authentication/userModel.dart';
import 'package:junkaday/junkList/dayJunkLog.dart';

class JunkMaster {
  // UserModel userModel;
  // DayJunkLog dayJunkLog;

  // JunkMaster(UserModel userModel, DayJunkLog dayJunkLog) {
  //   this.userModel = userModel;
  //   this.dayJunkLog = dayJunkLog;
  // }

  static onSpecificJunkAdded(UserModel userModel, DayJunkLog dayJunkLog) {
    // decrease health when the total units in a day cross a certain threshold
    if(true || dayJunkLog?.logs?.length == 39) {
      userModel.setHealth(userModel.getUserDetails().health - 1);
    }
  }

  onNewDay() {

  }


}