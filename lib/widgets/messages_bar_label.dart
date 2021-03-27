import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MessageBarLabel extends StatelessWidget {
  const MessageBarLabel({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.purple,
      child: SizedBox(
        width: double.infinity,
        height: 48,
        child: Center(
          child: Text(
            'Messages',
            style: GoogleFonts.teko(fontSize: 25, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
