import 'package:flutter/material.dart';
import 'package:bordered_text/bordered_text.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeButton extends StatelessWidget {
  const ThemeButton({
    super.key,
    required this.childText,
    required this.onPressed,
  });

  final String childText;
  final Function onPressed;

  final double width = 220;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Feedback.forTap(context);
        onPressed();
      },
      child: Stack(
        children: [
          Container(
            height: 48,
            width: width,
            decoration: BoxDecoration(
              color: Colors.green,
              gradient: const LinearGradient(colors: [
                Color.fromARGB(255, 188, 211, 106),
                Color(0xff65AC3A),
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
              border: Border.all(
                width: 2,
                color: Colors.black,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              height: 28,
              width: width - 8,
              decoration: BoxDecoration(
                color: Colors.green,
                gradient: const LinearGradient(colors: [
                  Color(0xffDDF685),
                  Color.fromARGB(255, 159, 202, 78),
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
          SizedBox(
            height: 48,
            width: width,
            child: BorderedText(
              strokeWidth: 4,
              child: Text(
                childText,
                style: GoogleFonts.lilitaOne(
                  textStyle: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
