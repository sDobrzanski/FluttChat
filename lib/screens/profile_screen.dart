import 'package:flutt_chat/widgets/custom_app_bar.dart';
import 'package:flutt_chat/widgets/login_button.dart';
import 'package:flutter/material.dart';
import 'package:flutt_chat/services/firestore_service.dart';
import 'package:flutt_chat/services/auth_service.dart';
import 'package:flutt_chat/constants.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _firestoreService = FirestoreService();

  final _authService = AuthService();
  String mainPhotoUrl;
  String uid;
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
                  onPressed: () {}, //TBD
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
