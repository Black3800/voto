import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voto_mobile/utils/color.dart';

class SimpleTextInput extends StatefulWidget {
  final String? initialValue;
  final MaterialColor accentColor;
  final IconData? icon;
  final String hintText;
  final String? errorText;
  final bool multiline;
  final bool clearable;
  final bool autofocus;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final void Function()? onEditingComplete;
  final void Function(String)? onFieldSubmitted;
  final void Function(String?)? onSaved;
  final int? max;
  const SimpleTextInput(
      {Key? key,
      this.initialValue,
      this.accentColor = VotoColors.black,
      this.icon,
      this.hintText = 'Aa',
      this.multiline = false,
      this.clearable = true,
      this.autofocus = false,
      this.keyboardType,
      this.inputFormatters,
      this.controller,
      this.errorText,
      this.onChanged,
      this.onTap,
      this.onEditingComplete,
      this.onFieldSubmitted,
      this.onSaved,
      this.max})
      : super(key: key);

  @override
  State<SimpleTextInput> createState() => _SimpleTextInputState();
}

class _SimpleTextInputState extends State<SimpleTextInput> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    /** WARNING: Assume supplied controller self-dispose */
    // widget.controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller ?? _controller,
      maxLength: widget.max,
      autofocus: widget.autofocus,
      initialValue: widget.initialValue,
      keyboardType: widget.keyboardType,
      inputFormatters: widget.inputFormatters,
      minLines: widget.multiline ? 4 : 1,
      maxLines: widget.multiline ? null : 1,
      style: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: widget.accentColor,
      ),
      onChanged: (value) {
        widget.onChanged?.call(value);
        setState(() {});
      },
      onTap: widget.onTap,
      onEditingComplete: widget.onEditingComplete,
      onFieldSubmitted: widget.onFieldSubmitted,
      onSaved: widget.onSaved,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsets.all(16.0),
        prefixIcon: widget.icon != null
            ? Icon(
                widget.icon,
                color: widget.accentColor,
              )
            : null,
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        hintText: widget.hintText,
        hintStyle: GoogleFonts.inter(color: const Color(0xffc4c4c4)),
        errorText: widget.errorText,
        fillColor: VotoColors.gray,
        filled: true,
        suffixIcon: widget.clearable &&
                (widget.controller ?? _controller).text.isNotEmpty
            ? InkWell(
                child: Icon(
                  Icons.close,
                  color: widget.accentColor,
                ),
                onTap: () {
                  (widget.controller ?? _controller).clear();
                  setState(() {});
                },
              )
            : null,
      ),
    );
  }
}
