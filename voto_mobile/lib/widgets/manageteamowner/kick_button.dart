import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voto_mobile/utils/color.dart';
import '../manageteam/outlinebutton.dart';

class KickButton extends StatelessWidget {
  const KickButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KickButtonn();
  }
}

class KickButtonn extends StatelessWidget {
  const KickButtonn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void confirmClickPopup() {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(
            'Are you sure you want to delete this member?',
            style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          content: Text(
            'If you kick this member, They will not belong to this group.',
            style:
                GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.normal),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.only(left: 20),
      // child: Outline_button("Kick", 30, 12, 10),
      child: ElevatedButton(
        onPressed: () {
          confirmClickPopup();
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          side: BorderSide(color: VotoColors.secondary, width: 1),
          padding: const EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
        child: Text(
          'Kick',
          style: GoogleFonts.inter(
              fontSize: 10.0,
              fontWeight: FontWeight.w600,
              color: VotoColors.secondary),
        ),
      ),
    );
  }
}
