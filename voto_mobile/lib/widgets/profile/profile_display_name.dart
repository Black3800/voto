import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileDisplayName extends StatelessWidget {
  final String name;
  const ProfileDisplayName({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _deviceHeight = MediaQuery.of(context).size.height;

    return Container(
      margin: const EdgeInsets.only(top: 10),
      height: _deviceHeight * 0.05,
      child: Text(
        name,
        style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}
