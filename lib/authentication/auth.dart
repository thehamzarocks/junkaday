import 'dart:io';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:junkaday/junkList/fileUtils.dart';
import 'package:junkaday/user.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class AuthService {
  static GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: [],
  );

  static Future<GoogleSignInAccount> handleSignIn() async {
    try {
      GoogleSignInAccount account = await googleSignIn.signIn();
      return account;
    } catch (error) {
      print(error);
    }
    return null;
  }

  static Future<void> handleSignOut() => googleSignIn.disconnect();

  static Future<void> storeUserDetails(User userDetails) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    final filePath = '$path/JunkADayUserDetails';
    if (FileSystemEntity.typeSync(filePath) == FileSystemEntityType.notFound) {
      File file = File(filePath);

      userDetails.health = 4;
      userDetails.maxHealth = 4;
      userDetails.mints = 100;
      userDetails.isSpirit = false;
      userDetails.mileStone = 0;
      userDetails.lastUpdated = DateTime.now().toString();
      userDetails.createdDate = FileUtils.getDateForFileName(DateTime.now());
      file.writeAsStringSync(userDetails.toString());
    }
  }

  static Future<User> getUserDetailsFromFile() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    final filePath = '$path/JunkADayUserDetails';
    if (FileSystemEntity.typeSync(filePath) == FileSystemEntityType.notFound) {
      return null;
    }
    File file = File(filePath);
    String fileContents = file.readAsStringSync();
    User userDetailsFromFile = User.fromJson(json.decode(fileContents));
    return userDetailsFromFile;
  }

  // TODO: this currently uses the locally stored user data only
  // Enhance this to sync with server and allow the user to choose
  // which version to keep in case of conflicts
  static Future<User> getUserDetails(email) async {
    // if the file containing user details is available, use that
    User userDetails = await getUserDetailsFromFile();
    if (userDetails != null) {
      return userDetails;
    }

    // otherwise we need to create a new file with the starting params
    // and also update the db with this new user
    userDetails = new User();

    // if the user already exists, it's ok
    final getResponse =
        await http.get('https://vet6qn.deta.dev/users/' + email);
    if (getResponse.statusCode == 200) {
      // User userDetails = User.fromJson(json.decode(getResponse.body));
      // await storeUserDetails(userDetails);
      await userDetails.setUserDetails(
          email: email,
          health: 4,
          maxHealth: 4,
          mints: 100,
          isSpirit: false,
          mintsWithSpirit: 0,
          mileStone: 0,
          createdDate: FileUtils.getDateForFileName(DateTime.now()));
      return userDetails;
    }
    // otherwise add the user to the db and then proceed
    else {
      final postResponse = await http.post('https://vet6qn.deta.dev/users/',
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{'email': email}));
      if (postResponse.statusCode == 200) {
        // await storeUserDetails(userDetails);
        await userDetails.setUserDetails(
            email: email,
            health: 4,
            maxHealth: 4,
            mints: 100,
            isSpirit: false,
            mintsWithSpirit: 0,
            mileStone: 0,
            createdDate: FileUtils.getDateForFileName(DateTime.now()));
        return userDetails;
        // return User.fromJson(json.decode(getResponse.body));
      }
      // if user creation also fails, throw exception
      throw Exception('Failed to get user details');
    }
  }
}
