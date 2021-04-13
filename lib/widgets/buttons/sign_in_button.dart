import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

class SignInButton extends StatelessWidget {
  final String text;
  final String imageDataString;
  final Function onPressed;
  SignInButton({this.imageDataString, this.onPressed, this.text});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.12,
      height: MediaQuery.of(context).size.width * 0.02,
      child: OutlinedButton(
        onPressed: onPressed,
        child: Row(
          children: <Widget>[
            Image(
              image: AssetImage(imageDataString),
              width: 20,
              height: 20,
            ),
            SizedBox(
              width: 10,
            ),
            Flexible(
              child: Text(
                text,
                style: GoogleFonts.teko(fontSize: 20, color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
