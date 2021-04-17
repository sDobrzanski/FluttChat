import 'package:flutter/material.dart';
import 'package:flutt_chat/services/auth_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutt_chat/bloc/authentication/authentication_bloc.dart';
import 'package:flutt_chat/bloc/authentication/authentication_event.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final User user;
  CustomAppBar({this.user});
  final _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthenticationBloc>(context);
    return AppBar(
      backgroundColor: Colors.purple[600],
      elevation: 2,
      shadowColor: Colors.purpleAccent,
      title: Row(
        children: [
          SizedBox(
            width: 60,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: IconButton(
                icon: Icon(
                  Icons.home_outlined,
                  size: 32,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/users');
                }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: IconButton(
                icon: Icon(
                  Icons.person,
                  size: 32,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/profile');
                }),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 5.0),
            child: Text(
              'Welcome ${user.email}!',
              style: GoogleFonts.teko(fontSize: 22, color: Colors.white),
            ),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 35.0),
          child: IconButton(
              icon: Icon(
                Icons.logout,
                size: 32,
              ),
              onPressed: () {
                authBloc.add(UserLoggedOut());
                Navigator.popAndPushNamed(context, '/');
              }),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
