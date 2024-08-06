import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle customtextstyle = GoogleFonts.ubuntu(color: Colors.white);
const Color kwhiteColor = Colors.white;

class CustomText extends StatelessWidget {
  final String text;
  final Color color;
  final FontWeight fw;
  final double fs;
  const CustomText(
      {super.key,
      required this.text,
      this.color = Colors.white,
      this.fw = FontWeight.w400,
      this.fs = 14});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width - 180,
      child: RichText(
          text: TextSpan(children: [
        TextSpan(
            text: text,
            style: GoogleFonts.ubuntu(
              color: color,
              fontSize: fs,
              height: 1.5,
              fontWeight: fw,
            ))
      ])),
    );
  }
}
