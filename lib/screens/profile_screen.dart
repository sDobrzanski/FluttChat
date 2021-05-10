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
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../bloc/photo/photo_bloc.dart';
import '../bloc/photo/photo_event.dart';
import '../bloc/photo/photo_state.dart';
import '../bloc/resetPassword/reset_password_bloc.dart';
import '../bloc/resetPassword/reset_password_event.dart';

class ProfileScreen extends StatefulWidget {
  final User user;
  ProfileScreen({this.user});
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        user: widget.user,
      ),
      body: SafeArea(child: BlocBuilder<PhotoBloc, PhotoState>(
        builder: (context, state) {
          if (state is PhotoLoaded) {
            return ProfileFuncs(
              photoUrl: state.url,
              user: widget.user,
            );
          }
          if (state is PhotoChanged) {
            return ProfileFuncs(
              photoUrl: state.url,
              user: widget.user,
            );
          }
          if (state is PhotoError) {
            return Text('Error: ${state.error}');
          }
          return Center(child: CircularProgressIndicator());
        },
      )),
    );
  }
}

class ProfileFuncs extends StatefulWidget {
  final String photoUrl;
  final User user;
  ProfileFuncs({this.photoUrl, this.user});

  @override
  _ProfileFuncsState createState() => _ProfileFuncsState();
}

class _ProfileFuncsState extends State<ProfileFuncs> {
  @override
  Widget build(BuildContext context) {
    final photoBloc = BlocProvider.of<PhotoBloc>(context);
    final resetPasswordBloc = BlocProvider.of<ResetPasswordBloc>(context);
    final firestoreService = RepositoryProvider.of<FirestoreService>(context);
    return Container(
        child: BlocProvider<PhotoBloc>(
      create: (context) => PhotoBloc(firestoreService),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40.0),
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                backgroundImage: NetworkImage(widget.photoUrl),
                radius: 70,
              ),
            ),
            LoginButton(
              text: 'Add a profile pic',
              color: Colors.purpleAccent,
              onPressed: () {
                photoBloc.add(ChangePhoto(uid: widget.user.uid));
              },
            ),
            LoginButton(
              text: 'Change password',
              color: Colors.purple,
              onPressed: () {
                resetPasswordBloc.add(ForgetPassword(email: widget.user.email));
                //TODO alert box
              },
            ),
          ],
        ),
      ),
    ));
  }
}
