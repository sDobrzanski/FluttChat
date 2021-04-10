import 'package:flutt_chat/widgets/animating_name.dart';
import 'package:flutt_chat/widgets/buttons/login_button.dart';
import 'package:flutter/material.dart';
import 'package:flutt_chat/widgets/text_fields/input_text_field.dart';
import 'package:flutt_chat/services/auth_service.dart';
import 'package:flutt_chat/widgets/custom_alert_dialog.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email;
  String password;
  String response;
  var _authService = AuthService();

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
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                }),
            SizedBox(
              height: 15,
            ),
            InputTextField(
                hintText: 'Enter you password',
                isPassword: true,
                icon: Icons.lock,
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                }),
            SizedBox(
              height: 30,
            ),
            LoginButton(
              text: 'Login',
              color: Colors.purpleAccent,
              onPressed: () async {
                await _authService
                    .login(email, password)
                    .then((value) => response = value);
                FocusScope.of(context).requestFocus(FocusNode());
                if (response == 'Logged In') {
                  Navigator.pushNamed(context, '/users');
                } else {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => CustomAlertDialog(
                            message: response,
                          ));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
