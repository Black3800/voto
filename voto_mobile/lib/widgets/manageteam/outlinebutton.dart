import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voto_mobile/utils/color.dart';

class Outline_button extends StatelessWidget {
  String title;
  double width;
  double high;
  double size;
  Outline_button(this.title, this.high, this.width, this.size);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () => {},
      style: OutlinedButton.styleFrom(
          fixedSize: Size(width, high),
          primary: VotoColors.secondary,
          backgroundColor: VotoColors.white,
          side: BorderSide(width: 1, color: VotoColors.secondary),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)))),
      child: Text(
        title,
        style: GoogleFonts.inter(
            color: VotoColors.secondary,
            fontWeight: FontWeight.w600,
            fontSize: size),
      ),
    );
  }
}
