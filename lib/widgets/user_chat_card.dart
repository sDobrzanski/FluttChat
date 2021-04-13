import 'package:flutter/material.dart';

class UserChatCard extends StatelessWidget {
  final String email;
  final ImageProvider userPic;
  final Function onPressed;
  final String message;
  UserChatCard({this.email, this.userPic, this.onPressed, this.message});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.1,
      height: MediaQuery.of(context).size.width * 0.08,
      child: GestureDetector(
        child: Card(
          color: Colors.purpleAccent[400],
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage: userPic,
                      radius: MediaQuery.of(context).size.width * 0.02,
                    ),
                    Text(
                      email,
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.014,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Text(
                  message,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.width * 0.012),
                ),
              )
            ],
          ),
        ),
        onTap: onPressed,
      ),
    );
  }
}
