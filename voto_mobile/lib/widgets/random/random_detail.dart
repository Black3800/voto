import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voto_mobile/utils/color.dart';

class RandomDetail extends StatelessWidget {
  const RandomDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 20,
        left: 35,
        right: 15,
        bottom: 10,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Random report part",
                style: GoogleFonts.inter(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Random who get to write each part",
                      style: GoogleFonts.inter(
                          fontSize: 14, fontWeight: FontWeight.normal),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
