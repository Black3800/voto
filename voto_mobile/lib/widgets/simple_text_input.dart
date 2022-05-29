import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voto_mobile/utils/color.dart';

class SimpleTextInput extends StatefulWidget {
  final String? initialValue;
  final MaterialColor accentColor;
  final Color hintColor;
  final double borderRadius;
  final IconData? icon;
  final String hintText;
  final String? errorText;
  final bool multiline;
  final bool clearable;
  final bool autofocus;
  final bool readOnly;
  final bool obscureText;
  final bool hideCounter;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;
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
      this.borderRadius = 12,
      this.hintText = 'Aa',
      this.hintColor = const Color(0xffc4c4c4),
      this.multiline = false,
      this.clearable = true,
      this.autofocus = false,
      this.readOnly = false,
      this.obscureText  = false,
      this.hideCounter = false,
      this.textInputAction,
      this.keyboardType,
      this.inputFormatters,
      this.controller,
      this.focusNode,
      this.validator,
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
      validator: widget.validator,
      focusNode: widget.focusNode,
      maxLength: widget.max,
      autofocus: widget.autofocus,
      initialValue: widget.initialValue,
      textInputAction: widget.textInputAction,
      keyboardType: widget.keyboardType,
      inputFormatters: widget.inputFormatters,
      minLines: widget.multiline ? 4 : 1,
      maxLines: widget.multiline ? null : 1,
      buildCounter: widget.readOnly || widget.hideCounter
          ? (context,
                  {required int currentLength,
                  required bool isFocused,
                  required int? maxLength}) =>
              null
          : null,
      style: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: widget.readOnly ? widget.accentColor.shade300 : widget.accentColor,
      ),
      onChanged: (value) {
        widget.onChanged?.call(value);
        setState(() {});
      },
      onTap: widget.onTap,
      onEditingComplete: widget.onEditingComplete,
      onFieldSubmitted: widget.onFieldSubmitted,
      onSaved: widget.onSaved,
      readOnly: widget.readOnly,
      obscureText: widget.obscureText,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsets.all(16.0),
        prefixIcon: widget.icon != null
            ? Icon(
                widget.icon,
                color: widget.readOnly
                    ? widget.accentColor.shade300
                    : widget.accentColor,
              )
            : null,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(
            Radius.circular(widget.borderRadius),
          ),
        ),
        hintText: widget.hintText,
        hintStyle: GoogleFonts.inter(color: widget.readOnly ? widget.hintColor.withOpacity(0.33) : widget.hintColor),
        errorText: widget.errorText,
        fillColor: widget.readOnly ? VotoColors.black.shade50 : VotoColors.gray,
        filled: true,
        suffixIcon: !widget.readOnly && widget.clearable &&
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
