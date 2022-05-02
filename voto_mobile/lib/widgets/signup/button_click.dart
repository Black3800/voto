import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voto_mobile/utils/color.dart';

class ButtonClick extends StatelessWidget {
  const ButtonClick({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 15,
        right: 25,
        left: 25,
      ),
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(47.0),
              ),
            ),
            child: Ink(
              decoration: const BoxDecoration(
                color: VotoColors.secondary,
                borderRadius: BorderRadius.all(Radius.circular(50.0)),
              ),
              child: Container(
                padding: const EdgeInsets.all(8),
                width: MediaQuery.of(context).size.width * 0.8,
                height: 45,
                child: Text(
                  "Sign Up",
                  style: GoogleFonts.inter(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
