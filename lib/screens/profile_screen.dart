import 'package:flutt_chat/widgets/custom_app_bar.dart';
import 'package:flutt_chat/widgets/buttons/login_button.dart';
import 'package:flutter/material.dart';
import 'package:flutt_chat/services/firestore_service.dart';
import 'package:flutt_chat/services/auth_service.dart';
import 'package:flutt_chat/constants.dart';
import 'package:flutt_chat/widgets/custom_alert_dialog.dart';
import 'package:flutt_chat/bloc/photo/photo_bloc.dart';
import 'package:flutt_chat/bloc/photo/photo_state.dart';
import 'package:flutt_chat/bloc/resetPassword/reset_password_bloc.dart';
import 'package:flutt_chat/bloc/resetPassword/reset_password_event.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _firestoreService = FirestoreService();
  final _authService = AuthService();
  String mainPhotoUrl;
  String uid;
  String response;
  bool isLoading = false;

  getPhoto() async {
    String photoUrl;
    await _firestoreService.getPhotoUrl(_authService.user.uid).then((value) {
      setState(() {
        photoUrl = value;
        isLoading = true;
      });
    });

    if (photoUrl != null) {
      setState(() {
        mainPhotoUrl = photoUrl;
        isLoading = true;
      });
    } else {
      mainPhotoUrl = kEmptyUserPhoto;
      isLoading = true;
    }
  }

  @override
  void initState() {
    super.initState();
    getPhoto();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SafeArea(
        child: Container(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                isLoading
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          backgroundImage: NetworkImage(mainPhotoUrl),
                          radius: 70,
                        ),
                      )
                    : CircularProgressIndicator(
                        backgroundColor: Colors.purple,
                      ),
                LoginButton(
                  text: 'Add a profile pic',
                  color: Colors.purpleAccent,
                  onPressed: () async {
                    await _firestoreService
                        .uploadToStorage(_authService.user.uid);
                  },
                ),
                LoginButton(
                  text: 'Change password',
                  color: Colors.purple,
                  onPressed: () async {
                    await _authService
                        .forgotPassword(_authService.user.email)
                        .then((value) {
                      setState(() {
                        response = value;
                      });
                    });
                    FocusScope.of(context).requestFocus(FocusNode());
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => CustomAlertDialog(
                              message: response,
                            ));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
