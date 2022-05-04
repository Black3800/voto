import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voto_mobile/utils/color.dart';

class Filed extends StatefulWidget {
  final String title;
  final double width;

  const Filed({Key? key, required this.title, required this.width})
      : super(key: key);

  @override
  State<Filed> createState() => _FiledState();
}

class _FiledState extends State<Filed> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 35,
        width: widget.width,
        child: TextField(
          decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: 15),
              hintText: widget.title,
              hintStyle: GoogleFonts.inter(color: Colors.black, fontSize: 12),
              filled: true,
              fillColor: Color(0xffF2F4F8),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none)),
          readOnly: true,
        ),
      );
  }
}
