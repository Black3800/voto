import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voto_mobile/utils/color.dart';

class BigButton extends StatelessWidget {
  final String text;
  final MaterialColor color;
  final Function()? onPressed;
  const BigButton({Key? key, required this.text, required this.onPressed, this.color = VotoColors.magenta}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: VotoColors.magenta,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
        minimumSize: const Size.fromHeight(55.0),
      ),
      child: Text(
        text,
        style: GoogleFonts.inter(fontSize: 14),
        textAlign: TextAlign.center,
      ),
    );
  }
}
