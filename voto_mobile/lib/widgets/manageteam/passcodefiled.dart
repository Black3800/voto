import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voto_mobile/utils/color.dart';

class Passcode extends StatefulWidget {
  String passNumber;
  bool isEditing;
  Passcode({Key? key, required this.passNumber, this.isEditing = false})
      : super(key: key);

  @override
  State<Passcode> createState() => _PasscodeState();
}

class _PasscodeState extends State<Passcode> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.5),
      decoration: BoxDecoration(
        color: VotoColors.gray,
        borderRadius: BorderRadius.circular(10.0)
      ),
      height: 56,
      width: 54,
      child: Center(
        child: Text(
          widget.passNumber == ' ' ? '_' : widget.passNumber,
          style: GoogleFonts.inter(
            color: VotoColors.black,
            fontSize: 32,
            fontWeight: FontWeight.w600
          ),
        ),
      ),
    );
  }
}
