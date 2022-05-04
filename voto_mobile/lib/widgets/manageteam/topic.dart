import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voto_mobile/utils/color.dart';

class Topic extends StatelessWidget {
  String topic;
  Topic(this.topic);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        topic,
        style: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
