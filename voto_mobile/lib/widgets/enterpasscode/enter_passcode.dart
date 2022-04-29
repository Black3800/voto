import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voto_mobile/utils/color.dart';

class EnterPasscode extends StatelessWidget {
  const EnterPasscode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(
          top: 20,
          right: 25,
          left: 15,
        ),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.clear, color: VotoColors.primary),
              onPressed: () {},
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
              ),
              child: Text(
                "Enter passcode",
                style: GoogleFonts.inter(
                    fontSize: 16,
                    color: VotoColors.primary,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
              ),
              child: Text(
                "The following team requires passcode to join",
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: VotoColors.primary,
                ),
              ),
            ),
          ],
        ));
  }
}
