import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voto_mobile/utils/color.dart';

class ProfileCustomEmailTextfield extends StatelessWidget {
  final TextEditingController controller;
  const ProfileCustomEmailTextfield({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10,
      ),
      child: TextFormField(
        controller: controller,
        style: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: const Color(0xff999999),
        ),
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.email,
            color: Color(0xff999999),
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(
              Radius.circular(18),
            ),
          ),
          hintText: 'Email',
          fillColor: VotoColors.black.shade50,
          filled: true,
        ),
        readOnly: true,
      ),
    );
  }
}
