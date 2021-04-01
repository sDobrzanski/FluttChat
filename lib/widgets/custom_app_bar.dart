import 'package:flutter/material.dart';
import 'package:flutt_chat/services/auth_service.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  var _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.purple[600],
      elevation: 2,
      shadowColor: Colors.purpleAccent,
      title: Row(
        children: [
          SizedBox(
            width: 32,
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
                  Icons.mail_outline,
                  size: 32,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/chat');
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
              onPressed: () async {
                await _authService.signOut();
                Navigator.popAndPushNamed(context, '/');
              }),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
