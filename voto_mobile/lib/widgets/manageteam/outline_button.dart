import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voto_mobile/utils/color.dart';

class OutlineButton extends StatelessWidget {
  final String text;
  final double? width;
  final double? height;
  final double fontSize;
  final double padding;
  final Function()? onPressed;
  const OutlineButton(
      {Key? key,
      required this.text,
      this.width,
      this.height,
      this.fontSize = 16.0,
      this.padding = 8.0,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed ?? () {},
      style: OutlinedButton.styleFrom(
          padding: EdgeInsets.all(padding),
          fixedSize: width != null ? Size(width ?? 0.0, height ?? 50.0) : null,
          minimumSize: width == null ? Size.fromHeight(height ?? 50.0) : null,
          primary: VotoColors.danger,
          backgroundColor: VotoColors.white,
          side: const BorderSide(width: 1, color: VotoColors.danger),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)))),
      child: Text(
        text,
        style: GoogleFonts.inter(
            color: VotoColors.danger,
            fontWeight: FontWeight.w600,
            fontSize: fontSize),
      ),
    );
  }
}
