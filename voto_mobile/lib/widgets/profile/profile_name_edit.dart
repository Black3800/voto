import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voto_mobile/utils/color.dart';
import 'package:voto_mobile/widgets/profile/profile_custom_email_textfield.dart';
import 'package:voto_mobile/widgets/profile/profile_custom_textfield.dart';
import 'package:voto_mobile/widgets/simple_text_input.dart';

class ProfileDisplayNameEditing extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  const ProfileDisplayNameEditing(
      {Key? key, required this.nameController, required this.emailController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.only(
        left: 40,
        right: 40,
      ),
      child: Column(
        children: [
          displayName(),
          SimpleTextInput(
            controller: nameController,
            max: 30,
            icon: Icons.people_rounded,
            accentColor: VotoColors.indigo,
          ),
          displayEmail(),
          SimpleTextInput(
            controller: emailController,
            max: 100,
            icon: Icons.mail_rounded,
            accentColor: VotoColors.black,
            readOnly: true
          ),
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
