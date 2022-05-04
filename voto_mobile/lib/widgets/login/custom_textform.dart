import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voto_mobile/utils/color.dart';

class CustomTextForm extends StatefulWidget {
  final TextEditingController controller;
  final bool isEmail;
  const CustomTextForm(
      {Key? key, required this.controller, required this.isEmail})
      : super(key: key);

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
      maxLength: widget.isEmail ? 50 : 100,
      buildCounter: (context, {required int currentLength, required int? maxLength, required bool isFocused}) => Container(),
      onChanged: ((value) {
        setState(() {});
      }),
      controller: widget.controller,
      decoration: InputDecoration(
        prefixIcon: Icon(
          widget.isEmail ? Icons.email_rounded : Icons.lock_rounded,
          color: VotoColors.primary,
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(
            Radius.circular(18),
          ),
        ),
        hintText: widget.isEmail ? 'Email' : 'Password',
        fillColor: VotoColors.white,
        filled: true,
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
      obscureText: !widget.isEmail,
    );
  }
}
