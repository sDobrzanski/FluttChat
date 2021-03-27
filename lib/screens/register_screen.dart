import 'package:flutt_chat/widgets/animating_name.dart';
import 'package:flutt_chat/widgets/login_button.dart';
import 'package:flutter/material.dart';
import 'package:flutt_chat/widgets/input_text_field.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 250,
              height: 250,
              child: Hero(
                tag: 'logo',
                child: Image(
                  image: AssetImage('images/logo.png'),
                ),
              ),
            ),
            AnimatingName(),
            InputTextField(
                hintText: 'Enter you email',
                isPassword: false,
                icon: Icons.email,
                onChanged: (value) {}),
            SizedBox(
              height: 15,
            ),
            InputTextField(
                hintText: 'Enter you password',
                isPassword: true,
                icon: Icons.lock,
                onChanged: (value) {}),
            SizedBox(
              height: 15,
            ),
            InputTextField(
                hintText: 'Repeat you password',
                isPassword: true,
                onChanged: (value) {}),
            SizedBox(
              height: 30,
            ),
            LoginButton(
              text: 'Register',
              color: Colors.purpleAccent,
              onPressed: () {
                Navigator.pushNamed(context, '/chat');
              },
            ),
          ],
        ),
      ),
    );
  }
}
