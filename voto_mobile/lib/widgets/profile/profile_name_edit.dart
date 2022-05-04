import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voto_mobile/widgets/profile/profile_custom_email_textfield.dart';
import 'package:voto_mobile/widgets/profile/profile_custom_textfield.dart';

class ProfileDisplayNameEditing extends StatelessWidget {
  final String name;
  final String email;
  const ProfileDisplayNameEditing(
      {Key? key, required this.name, required this.email})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _deviceHeight = MediaQuery.of(context).size.height;

    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.only(
        left: 40,
        right: 40,
      ),
      height: _deviceHeight * 0.27,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          displayName(),
          ProfileCustomTextField(initialValue: name),
          displayEmail(),
          ProfileCustomEmailTextField(initialValue: email),
        ],
      ),
    );
  }

  Widget displayName() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      alignment: Alignment.centerLeft,
      child: Text(
        'Display name',
        style: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget displayEmail() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      alignment: Alignment.centerLeft,
      child: Text(
        'Email',
        style: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
