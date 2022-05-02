import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voto_mobile/utils/color.dart';

class SignUpClick extends StatelessWidget {
  const SignUpClick({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RichText(
            text: const TextSpan(
              text: "Don't have account? ",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/signup_page');
            },
            child: Text(
              'Sign up',
              style: GoogleFonts.inter(
                color: VotoColors.magenta,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      );
  }
}
