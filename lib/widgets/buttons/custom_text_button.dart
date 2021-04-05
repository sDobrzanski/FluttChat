import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  CustomTextButton({this.onPressed, this.text});
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: GoogleFonts.teko(fontSize: 20, color: Colors.purple),
      ),
    );
  }
}
