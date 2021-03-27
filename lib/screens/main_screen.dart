import 'package:flutt_chat/widgets/sign_in_button.dart';
import 'package:flutter/material.dart';
import 'package:flutt_chat/widgets/login_button.dart';
import 'package:flutt_chat/widgets/animating_name.dart';

class MainScreen extends StatelessWidget {
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
                onPressed: () {},
              ),
              SignInButton(
                imageDataString: 'images/google.png',
                text: 'Sign in with Google',
                onPressed: () {},
              ),
            ],
          ),
        ],
      )),
    );
  }
}
