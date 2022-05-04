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
      onPressed: () {},
      style: OutlinedButton.styleFrom(
          padding: EdgeInsets.all(padding),
          fixedSize: width != null ? Size(width ?? 0.0, height ?? 50.0) : null,
          minimumSize: width == null ? Size.fromHeight(height ?? 50.0) : null,
          primary: VotoColors.danger,
          backgroundColor: VotoColors.white,
          side: const BorderSide(width: 1, color: VotoColors.danger),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)))),
      child: Text(
        text,
        style: GoogleFonts.inter(
            color: VotoColors.danger,
            fontWeight: FontWeight.w600,
            fontSize: fontSize),
      ),
    );
  }
}
