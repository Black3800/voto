import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voto_mobile/utils/color.dart';

class CustomTextForm extends StatefulWidget {
  final TextEditingController controller;
  final int maxLength;
  final String hintText;
  final IconData icon;
  final bool obscureText;
  final MaterialColor fillColor;
  final String? Function(String?)? validator;
  const CustomTextForm({
    Key? key,
    required this.controller,
    this.maxLength = 50,
    this.hintText = 'Aa',
    this.icon = Icons.email_rounded,
    this.obscureText = false,
    this.fillColor = VotoColors.white,
    this.validator
  }) : super(key: key);

  @override
  State<CustomTextForm> createState() => _CustomTextFormState();
}

class _CustomTextFormState extends State<CustomTextForm> {
  void _clearTextField(TextEditingController controller) {
    // Clear everything in the text field
    controller.clear();
    // Call setState to update the UI
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: widget.maxLength,
      buildCounter: (context, {required int currentLength, required int? maxLength, required bool isFocused}) => Container(),
      onChanged: ((value) {
        setState(() {});
      }),
      controller: widget.controller,
      validator: widget.validator,
      decoration: InputDecoration(
        prefixIcon: Icon(
          widget.icon,
          color: VotoColors.primary,
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(
            Radius.circular(18),
          ),
        ),
        hintText: widget.hintText,
        fillColor: widget.fillColor,
        filled: true,
        errorStyle: GoogleFonts.inter(
          fontSize: 12.0,
          color: VotoColors.danger
        ),
        suffixIcon: widget.controller.text.isEmpty
            ? null
            : IconButton(
                onPressed: (() => _clearTextField(widget.controller)),
                icon: const Icon(
                  Icons.clear,
                  color: Colors.black54,
                ),
              ),
      ),
      style: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: VotoColors.primary,
      ),
      cursorColor: VotoColors.primary,
      obscureText: widget.obscureText,
    );
  }
}
