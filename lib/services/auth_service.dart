import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  final _google = GoogleSignIn();
  final _facebook = FacebookAuth.instance;
  User get user => _auth.currentUser;

  Future<bool> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      return false;
    }
  }

  Future<UserCredential> register(String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      print('user signed out');
    } catch (e) {
      throw (e);
    }
  }

  Future<User> googleSignIn() async {
    final GoogleSignInAccount googleSignInAccount = await _google.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final UserCredential authResult =
        await _auth.signInWithCredential(credential);
    final User user = authResult.user;

    if (user != null) {
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final User currentUser = _auth.currentUser;
      assert(user.uid == currentUser.uid);

      return user;
    }

    return null;
  }

  Future<void> googleSignOut() async {
    try {
      await _google.signOut();
      print('user signed out');
    } catch (e) {
      throw (e);
    }
  }

  Future<UserCredential> facebookLogin() async {
    final LoginResult result = await _facebook.login();
    if (result.status == LoginStatus.success) {
      final OAuthCredential credential =
          FacebookAuthProvider.credential(result.accessToken.token);
      return await _auth.signInWithCredential(credential);
    }
    return null;
  }

  Future<void> fbSignOut() async {
    try {
      await _facebook.logOut();
      print('user signed out');
    } catch (e) {
      throw (e);
    }
  }
}
