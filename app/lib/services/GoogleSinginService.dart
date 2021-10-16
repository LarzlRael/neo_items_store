import 'package:google_sign_in/google_sign_in.dart';

class GoogleSinginService {
  static GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );

  static Future<GoogleSignInAccount?> siginWithGoogle() async {
    try {
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      final googleKey = await account!.authentication;
      print(account);
      print('============ ID TOKEN =============');
      print(googleKey.idToken);

      //TODO call rest service to our backend

      return account;
    } catch (e) {
      print('Error en google Signin');
      print(e);
      return null;
    }
  }

  static Future signOut() async {
    await _googleSignIn.signOut();
  }
}
