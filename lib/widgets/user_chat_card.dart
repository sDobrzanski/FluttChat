import 'package:flutter/material.dart';

class UserChatCard extends StatelessWidget {
  final String email;
  final ImageProvider userPic;
  final Function onPressed;
  final String message;
  UserChatCard({this.email, this.userPic, this.onPressed, this.message});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage: userPic,
                      radius: 45,
                    ),
                  ),
                  Text(
                    email,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Text(
                  message,
                  style: TextStyle(color: Colors.white, fontSize: 16),
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
