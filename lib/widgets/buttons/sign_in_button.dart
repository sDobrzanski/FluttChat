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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 680.0, vertical: 5),
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
              Text(
                text,
                style: GoogleFonts.teko(fontSize: 20, color: Colors.blue),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
