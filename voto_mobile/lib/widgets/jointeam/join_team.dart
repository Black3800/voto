import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voto_mobile/utils/color.dart';

class JoinTeam extends StatelessWidget {
  const JoinTeam({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 15,
        left: 15,
        bottom: 20,
      ),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.clear, color: VotoColors.primary),
                onPressed: () {},
              ),
              Padding(
                padding: const EdgeInsets.only(
                  right: 60,
                ),
                child: Text(
                  "Join Team",
                  style: GoogleFonts.inter(
                      fontSize: 20,
                      color: VotoColors.primary,
                      fontWeight: FontWeight.w500),
                  // textAlign: TextAlign.center,
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
            ),
            child: Text(
              "Enter team’s join code or the link you received",
              style: GoogleFonts.inter(
                  fontSize: 14,
                  color: VotoColors.primary,
                  fontWeight: FontWeight.normal),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
            ),
            child: Text(
              "Join Code",
              style: GoogleFonts.inter(
                  fontSize: 14,
                  color: VotoColors.primary,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
