import 'package:flutt_chat/bloc/register/register_event.dart';
import 'package:flutt_chat/screens/login_screen.dart';
import 'package:flutt_chat/screens/register_screen.dart';
import 'package:flutt_chat/widgets/buttons/sign_in_button.dart';
import 'package:flutter/material.dart';
import 'package:flutt_chat/widgets/buttons/login_button.dart';
import 'package:flutt_chat/widgets/animating_name.dart';
import 'package:flutt_chat/widgets/buttons/custom_text_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutt_chat/bloc/register/register_bloc.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _registerBloc = BlocProvider.of<RegisterBloc>(context);
    return Scaffold(
      body: Center(
        child: Container(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                ),
                LoginButton(
                  text: 'Register',
                  color: Colors.purple,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterScreen()));
                  },
                ),
                SignInButton(
                  imageDataString: 'images/facebook.png',
                  text: 'Sign in with Facebook',
                  onPressed: () {
                    _registerBloc.add(SignInWithFacebook());
                  },
                ),
                SignInButton(
                  imageDataString: 'images/google.png',
                  text: 'Sign in with Google',
                  onPressed: () {
                    _registerBloc.add(SignInWithGoogle());
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
      ),
    );
  }
}
