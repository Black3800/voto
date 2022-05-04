import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voto_mobile/utils/color.dart';

class Filed extends StatefulWidget {
  final String text;
  final bool readOnly;

  const Filed({Key? key, required this.text, this.readOnly = true})
      : super(key: key);

  @override
  State<Filed> createState() => _FiledState();
}

class _FiledState extends State<Filed> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: widget.readOnly ? 35.0 : 50.0,
        child: TextFormField(
          maxLength: 30,
          buildCounter: widget.readOnly
              ? (context,
                      {required int currentLength,
                      required bool isFocused,
                      required int? maxLength}) =>
                  null
              : null,
          initialValue: widget.text,
          style: GoogleFonts.inter(fontSize: 12.0),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(15.0),
            filled: true,
            fillColor: VotoColors.gray,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none),
            suffixIcon: widget.readOnly
                ? null
                : const Icon(
                    Icons.edit_outlined,
                    color: Color(0xff7f8082),
                  ),
          ),
          readOnly: widget.readOnly,
        ),
      ),
    );
  }
}
