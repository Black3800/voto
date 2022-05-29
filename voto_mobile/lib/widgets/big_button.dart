import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voto_mobile/utils/color.dart';

class BigButton extends StatelessWidget {
  final String text;
  final MaterialColor color;
  final bool isLoading;
  final Function()? onPressed;
  const BigButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.color = VotoColors.magenta,
    this.isLoading = false
  }) : super(key: key);
   
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        primary: VotoColors.magenta,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
        minimumSize: const Size.fromHeight(45.0),
      ),
      child: isLoading
          ? const SizedBox(
              width: 30,
              height: 30,
              child: CircularProgressIndicator(
                  color: VotoColors.white
                ),
            )
          : Text(
              text,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: VotoColors.white
              ),
              textAlign: TextAlign.center,
            ),
    );
  }
}
