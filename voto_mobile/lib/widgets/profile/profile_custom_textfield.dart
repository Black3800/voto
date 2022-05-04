import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voto_mobile/utils/color.dart';

class ProfileCustomTextField extends StatefulWidget {
  final String initialValue;
  const ProfileCustomTextField({Key? key, this.initialValue = ''})
      : super(key: key);

  @override
  State<ProfileCustomTextField> createState() => _ProfileCustomTextFieldState();
}

class _ProfileCustomTextFieldState extends State<ProfileCustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10,
      ),
      child: TextFormField(
        maxLength: 30,
        initialValue: widget.initialValue,
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
