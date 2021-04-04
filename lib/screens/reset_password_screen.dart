import 'package:flutt_chat/widgets/animating_name.dart';
import 'package:flutt_chat/widgets/custom_alert_dialog.dart';
import 'package:flutt_chat/widgets/login_button.dart';
import 'package:flutter/material.dart';
import 'package:flutt_chat/services/auth_service.dart';
import 'package:flutt_chat/widgets/input_text_field.dart';

class ResetPasswordScreen extends StatefulWidget {
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  String email;

  final _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    String messageText;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                child: Image(
                  image: AssetImage('images/logo.png'),
                  width: 200,
                  height: 200,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15, bottom: 30),
                child: Center(child: AnimatingName()),
              ),
              InputTextField(
                hintText: 'Enter email',
                isPassword: false,
                icon: Icons.email,
                onChanged: (value) {
                  email = value;
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 20),
                child: LoginButton(
                  text: 'Reset',
                  color: Colors.purple,
                  onPressed: () async {
                    await _authService.forgotPassword(email).then((value) {
                      setState(() {
                        messageText = value;
                      });
                    });
                    FocusScope.of(context).requestFocus(FocusNode());
                    if (messageText == 'Email sent.') {
                      Navigator.popAndPushNamed(context, '/');
                    } else {}
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => CustomAlertDialog(
                              message: messageText,
                            ));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
