import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final String email;
  final ImageProvider userPic;
  final Function onPressed;
  UserCard({this.email, this.userPic, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.22,
      child: Card(
        color: Colors.deepPurpleAccent[100],
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
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
            Column(
              children: [
                Text(
                  email,
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ],
            ),
            TextButton(
              child: Icon(
                Icons.mail_outline,
                color: Colors.white,
                size: 30,
              ),
              onPressed: onPressed,
            ),
          ],
        ),
      ),
    );
  }
}
