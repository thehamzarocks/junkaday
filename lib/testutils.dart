import 'dart:io';

import 'package:flutter/material.dart';
import 'package:junkaday/junkList/fileUtils.dart';

import 'package:path_provider/path_provider.dart';

class TestUtils extends StatelessWidget {
  // deletes all files (simulates a fresh install, day 1)
  resetData() async {
    await FileUtils.deleteAllFiles();
  }

  // deletes yesterday's file,
  // renames current day's file to yesterday's date,
  // if no file today, simply deletes today's file
  // (simulates a new day)
  newDay() async {
    String yesterdayDate = FileUtils.getDateForFileName(
        DateTime.now().subtract(Duration(days: 1)));
    File yesterdayLog =
        await FileUtils.getFileOrCreateNew(fileName: yesterdayDate);
    if (yesterdayLog != null) {
      yesterdayLog.delete();
    }
    String todayFile = FileUtils.getDateForFileName(DateTime.now());
    File todayLog = await FileUtils.getFile(fileName: todayFile);
    if (todayLog == null) {
      return;
    }
    final Directory directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    final filePath = '$path/$yesterdayDate';
    return todayLog.rename(filePath);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          RaisedButton(child: Text('New Day'), onPressed: newDay),
          RaisedButton(child: Text('Reset'), onPressed: resetData),
        ],
      ),
    );
  }
}
