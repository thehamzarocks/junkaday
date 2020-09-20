import 'dart:io';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:junkaday/authentication/userModel.dart';
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
      file.writeAsStringSync(userDetails.toString());
    }
  }

  static Future<User> getUserDetails(email) async {
    // if the user already exists, get the data
    final getResponse =
        await http.get('https://vet6qn.deta.dev/users/' + email);
    if (getResponse.statusCode == 200) {
      User userDetails = User.fromJson(json.decode(getResponse.body));
      await storeUserDetails(userDetails);
      return userDetails;
    }
    // otherwise add the user to the db and get the data
    else {
      final postResponse = await http.post('https://vet6qn.deta.dev/users/',
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{'email': email}));
      if (postResponse.statusCode == 200) {
        return User.fromJson(json.decode(getResponse.body));
      }
      // if user creation also fails, throw exception
      throw Exception('Failed to get user details');
    }
  }
}
