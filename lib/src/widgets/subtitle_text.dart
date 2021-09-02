import 'package:flutter/material.dart';
import 'package:armod_flutter_store/src/themes/light_color.dart';
import 'package:google_fonts/google_fonts.dart';

class SubTitleText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;
  const SubTitleText(
      {Key? key,
      required this.text,
      this.fontSize = 18,
      this.color = LightColor.titleTextColor,
      this.fontWeight = FontWeight.w500})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 32,
        child: Text(text,
            overflow: TextOverflow.ellipsis,
            softWrap: true,
            maxLines: 2,
            style: GoogleFonts.mulish(
                fontSize: fontSize, fontWeight: fontWeight, color: color)));
  }
}
