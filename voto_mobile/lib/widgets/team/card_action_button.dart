import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voto_mobile/utils/color.dart';

class CardActionButton extends StatelessWidget {
  final String text;
  final MaterialColor accentColor;
  final bool isPrimary;
  final Function()? onPressed;
  const CardActionButton({ Key? key, required this.text, required this.onPressed, this.isPrimary = true, this.accentColor = VotoColors.indigo }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(boxShadow: <BoxShadow>[
        BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.15),
            blurRadius: 4.0,
            offset: Offset(2.0, 4.0))
      ], borderRadius: BorderRadius.all(Radius.circular(20.0))),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Padding(
            padding: const EdgeInsets.all(2.5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(text,
                      style: GoogleFonts.inter(
                          color: isPrimary ? VotoColors.white : accentColor,
                          fontSize: 11.0,
                          fontWeight: FontWeight.bold)),
                Icon(Icons.chevron_right, color: isPrimary ? VotoColors.white : accentColor)
              ],)
        ),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.pressed)) {
                return isPrimary ? accentColor.shade800 : VotoColors.white.shade800;
              }
              return isPrimary ? accentColor : VotoColors.white;
            }),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            )),
            elevation: MaterialStateProperty.all<double>(0.0),
            minimumSize:
                MaterialStateProperty.all<Size>(const Size.fromHeight(30.0))),
      ),
    );
  }
}