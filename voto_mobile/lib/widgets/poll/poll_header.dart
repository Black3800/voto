import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PollHeader extends StatelessWidget {
  const PollHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        pollTitle(),
        const SizedBox(height: 20),
        pollDetail(),
      ],
    );
  }

  Widget pollTitle() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Vote for today’s lunch',
            style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          Text(
            'Closing on 23 April 2022, 10:00',
            style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w300),
          )
        ],
      ),
    );
  }

  Widget pollDetail() {
    return SizedBox(
      height: 34,
      child: Text(
        'Let’s order some food for lunch today. Pick two choices you would like as your lunch!',
        style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w400),
      ),
    );
  }
}
