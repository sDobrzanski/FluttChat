import 'package:flutt_chat/widgets/animating_name.dart';
import 'package:flutt_chat/widgets/buttons/login_button.dart';
import 'package:flutter/material.dart';
import 'package:flutt_chat/widgets/text_fields/input_text_field.dart';
import 'package:flutt_chat/services/auth_service.dart';
import 'package:flutt_chat/services/firestore_service.dart';
import 'package:flutt_chat/widgets/custom_alert_dialog.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String email;

  String password;
  String repeatedPassword;
  var _authService = AuthService();

  var _firestoreService = FirestoreService();

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
              height: 15,
            ),
            InputTextField(
                hintText: 'Repeat you password',
                isPassword: true,
                onChanged: (value) {
                  setState(() {
                    setState(() {
                      repeatedPassword = value;
                    });
                  });
                }),
            SizedBox(
              height: 30,
            ),
            LoginButton(
              text: 'Register',
              color: Colors.purpleAccent,
              onPressed: () async {
                var newUser = await _authService.register(email, password);
                FocusScope.of(context).requestFocus(FocusNode());
                if (newUser != null) {
                  await _firestoreService.saveUser(newUser.user.uid, email);
                  Navigator.pushNamed(context, '/users');
                } else {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => CustomAlertDialog(
                            message: 'Couldn\'t register.',
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
