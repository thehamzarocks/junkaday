import 'package:google_sign_in/google_sign_in.dart';
import 'package:junkaday/authentication/userModel.dart';
import 'package:junkaday/user.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

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

  static Future<User> getUserDetails(email) async {
    final getResponse =
        await http.get('https://vet6qn.deta.dev/users/' + email);
    if (getResponse.statusCode == 200) {
      User userDetails = User.fromJson(json.decode(getResponse.body));
      UserModel(userDetails.email, userDetails.frownys, userDetails.health);
      // userDetailsProvider.setUserModel(
      //     userDetails.email, userDetails.frownys, userDetails.health);
      return userDetails;
    } else {
      final postResponse = await http.post('https://vet6qn.deta.dev/users/',
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{'email': email}));
      if (postResponse.statusCode == 200) {
        User userDetails = User.fromJson(json.decode(getResponse.body));
        UserModel(userDetails.email, userDetails.frownys, userDetails.health);
        // userDetailsProvider.setUserModel(
        //     userDetails.email, userDetails.frownys, userDetails.health);
        return userDetails;
      }
      throw Exception('Failed to get user details');
    }
  }
}
