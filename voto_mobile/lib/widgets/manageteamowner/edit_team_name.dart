import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voto_mobile/utils/color.dart';

class EditTeamName extends StatelessWidget {
  final String name;
  const EditTeamName({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _deviceHeight = MediaQuery.of(context).size.height;

    return Container(
      margin: const EdgeInsets.only(bottom: 10, top: 5),
      height: _deviceHeight * 0.06,
      child: TextFormField(
        maxLength: 30,
        // name,

        style: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.normal,
        ),

        decoration: const InputDecoration(
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(
              Radius.circular(18),
            ),
          ),
          fillColor: Color(0xFFF2F4F8),
          filled: true,
          suffixIcon: Icon(
            Icons.edit_outlined,
            color: Color(0xFF7F8082),
          ),
        ),
      ),
    );
  }
}
