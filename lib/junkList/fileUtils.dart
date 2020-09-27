import 'dart:io';
import 'package:junkaday/junkList/dayJunkLog.dart';
import 'package:junkaday/user.dart';
import 'package:path_provider/path_provider.dart';
import "dart:convert";

class FileUtils {
  static String getDateForFileName(DateTime dateTime) {
    return "junkLog" +
        "_" +
        dateTime.year.toString() +
        "_" +
        dateTime.month.toString() +
        "_" +
        dateTime.day.toString();
  }

  static Future<DayJunkLog> getPreviousDayLog() async {
    var today = DateTime.now();
    var yesterday = today.subtract(Duration(days: 1));
    File previousDayLogFile =
        await getFile(fileName: getDateForFileName(yesterday));
    if (previousDayLogFile == null) {
      return null;
    }
    String fileContents = await previousDayLogFile.readAsString();
    DayJunkLog previousDayJunkLog =
        DayJunkLog.fromJson(json.decode(fileContents));
    return previousDayJunkLog;
  }

  static Future<void> updateCurrentDayJunkLog(DayJunkLog dayJunkLog) async {
    File currentDayJunkLogFile =
        await getFileOrCreateNew(fileName: getDateForFileName(DateTime.now()));
    currentDayJunkLogFile.writeAsStringSync(dayJunkLog.toString());
  }

  static Future<void> writeUserDetailsToFile(User userDetails) async {
    File userDetailsFile = await getFileOrCreateNew(fileName: "JunkADayUserDetails");
    
    userDetailsFile.writeAsStringSync(userDetails.toString());
  }

  static Future<File> getFile({String fileName}) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    final filePath = '$path/$fileName';
    if (FileSystemEntity.typeSync(filePath) == FileSystemEntityType.notFound) {
      return null;
    }
    File file = File(filePath);
    return file;
  }

  static Future<File> getFileOrCreateNew({String fileName}) async{
    final Directory directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    final filePath = '$path/$fileName';
    return File(filePath);
    
    
  }
}
