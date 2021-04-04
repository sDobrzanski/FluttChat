import 'package:flutt_chat/widgets/sign_in_button.dart';
import 'package:flutter/material.dart';
import 'package:flutt_chat/widgets/login_button.dart';
import 'package:flutt_chat/widgets/animating_name.dart';
import 'package:flutt_chat/services/auth_service.dart';
import 'package:flutt_chat/services/firestore_service.dart';
import 'package:flutt_chat/widgets/custom_text_button.dart';

class MainScreen extends StatelessWidget {
  final _authService = AuthService();
  final _firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: 200,
            height: 200,
            child: Hero(
              tag: 'logo',
              child: Image(
                image: AssetImage('images/logo.png'),
              ),
            ),
          ),
          SizedBox(
            width: 250,
            height: 100,
            child: AnimatingName(),
          ),
          Column(
            children: [
              LoginButton(
                text: 'Login',
                color: Colors.purpleAccent,
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
              ),
              LoginButton(
                text: 'Register',
                color: Colors.purple,
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
              ),
              SignInButton(
                imageDataString: 'images/facebook.png',
                text: 'Sign in with Facebook',
                onPressed: () async {
                  try {
                    await _authService.facebookLogin().then((user) async {
                      if (user != null) {
                        await _firestoreService.saveUser(
                            user.user.uid, user.user.email);
                        Navigator.popAndPushNamed(context, '/users');
                      }
                    });
                  } catch (e) {
                    print(e);
                  }
                },
              ),
              SignInButton(
                imageDataString: 'images/google.png',
                text: 'Sign in with Google',
                onPressed: () async {
                  try {
                    await _authService.googleSignIn().then((user) async {
                      if (user != null) {
                        await _firestoreService.saveUser(user.uid, user.email);
                        Navigator.popAndPushNamed(context, '/users');
                      } else {
                        print('Couldnt sign in with google');
                      }
                    });
                  } catch (e) {
                    print(e);
                  }
                },
              ),
              CustomTextButton(
                onPressed: () {
                  Navigator.popAndPushNamed(context, '/resetPassword');
                },
                text: 'Forget a password?',
              )
            ],
          ),
        ],
      )),
    );
  }
}
