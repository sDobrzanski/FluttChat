import 'package:flutt_chat/bloc/usersStream/users_stream_bloc.dart';
import 'package:flutt_chat/bloc/usersStream/users_stream_event.dart';
import 'package:flutt_chat/screens/users_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutt_chat/bloc/authentication/authentication_bloc.dart';
import 'package:flutt_chat/bloc/authentication/authentication_event.dart';
import 'package:flutt_chat/bloc/chatsStream/chats_stream_bloc.dart';
import 'package:flutt_chat/bloc/chatsStream/chats_Stream_event.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final User user;
  CustomAppBar({this.user});
  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthenticationBloc>(context);
    final usersBloc = BlocProvider.of<UsersStreamBloc>(context);
    final _chatsStreamBloc = BlocProvider.of<ChatsStreamBloc>(context);
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
                  usersBloc.add(LoadRandomUsers());
                  _chatsStreamBloc.add(LoadUsers(id: user.uid));
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UsersScreen(
                                user: user,
                              )));
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
