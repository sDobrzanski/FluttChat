import 'package:flutt_chat/bloc/resetPassword/reset_password_bloc.dart';
import 'package:flutt_chat/bloc/resetPassword/reset_password_event.dart';
import 'package:flutt_chat/widgets/animating_name.dart';
import 'package:flutt_chat/widgets/custom_alert_dialog.dart';
import 'package:flutt_chat/widgets/buttons/login_button.dart';
import 'package:flutter/material.dart';
import 'package:flutt_chat/widgets/text_fields/input_text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordScreen extends StatefulWidget {
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  String email;

  @override
  Widget build(BuildContext context) {
    final _resetPasswordBloc = BlocProvider.of<ResetPasswordBloc>(context);
    String messageText;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
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
                    // await _authService.forgotPassword(email).then((value) {
                    //   setState(() {
                    //     messageText = value;
                    //   });
                    // });
                    // FocusScope.of(context).requestFocus(FocusNode());
                    // if (messageText == 'Email sent.') {
                    //   Navigator.popAndPushNamed(context, '/');
                    // } else {}
                    // showDialog(
                    //     context: context,
                    //     builder: (BuildContext context) => CustomAlertDialog(
                    //           message: messageText,
                    //         ));
                    _resetPasswordBloc
                        .add(ForgetPassword(email: email)); //TODO alertBox
                    FocusScope.of(context).requestFocus(FocusNode());
                    Navigator.popAndPushNamed(context, '/');
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
