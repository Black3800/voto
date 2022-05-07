import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voto_mobile/utils/color.dart';

class Passcode extends StatefulWidget {
  int passNumber;
  bool isEditing;
  Passcode({Key? key, required this.passNumber, required this.isEditing})
      : super(key: key);

  @override
  State<Passcode> createState() => _PasscodeState();
}

class _PasscodeState extends State<Passcode> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8.5),
        height: 56,
        width: 54,
        child: TextFormField(
          initialValue: widget.passNumber.toString(),
          style: GoogleFonts.inter(
              color: Colors.black, fontSize: 32, fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              // hintText: widget.passNumber.toString(),
              // hintStyle: GoogleFonts.inter(
              //     color: Colors.black,
              //     fontSize: 32,
              //     fontWeight: FontWeight.w600),
              filled: true,
              fillColor: Color(0xffF2F4F8),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none)),
          readOnly: widget.isEditing,
        ),
      ),
    );
  }
}
