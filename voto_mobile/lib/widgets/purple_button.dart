import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voto_mobile/utils/color.dart';

class Purple_button extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: (VotoColors.indigo),
        fixedSize: const Size.fromHeight(35),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onPressed: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.copy, size: 16),
          SizedBox(width: 10.0),
          Text(
            'Copy link to team',
            style: GoogleFonts.inter(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
