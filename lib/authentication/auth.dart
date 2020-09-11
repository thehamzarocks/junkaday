import 'package:google_sign_in/google_sign_in.dart';

class AuthService {

  static GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: [],
  );

  static Future<void> handleSignIn() async {
    try {
      await googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  static Future<void> handleSignOut() => googleSignIn.disconnect();
}
