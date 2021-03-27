import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class AnimatingName extends StatelessWidget {
  const AnimatingName({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedTextKit(
        animatedTexts: [
          TypewriterAnimatedText('FluttChat',
              speed: Duration(milliseconds: 70),
              textStyle:
                  GoogleFonts.teko(fontSize: 60, color: Colors.purpleAccent)),
        ],
        totalRepeatCount: 3,
      ),
    );
  }
}
