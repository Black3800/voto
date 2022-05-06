import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voto_mobile/utils/color.dart';

class ProfileCustomTextfield extends StatelessWidget {
  final TextEditingController controller;
  const ProfileCustomTextfield({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10,
      ),
      child: TextFormField(
        maxLength: 30,
        controller: controller,
        style: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: VotoColors.indigo,
        ),
        decoration: const InputDecoration(
          prefixIcon: Icon(
            Icons.account_circle,
            color: VotoColors.primary,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(
              Radius.circular(18),
            ),
          ),
          hintText: 'User display name',
          fillColor: Color(0xFFE5E5E5),
          filled: true,
          suffixIcon: Icon(
            Icons.edit,
            color: VotoColors.indigo,
          ),
        ),
      ),
    );
  }
}
