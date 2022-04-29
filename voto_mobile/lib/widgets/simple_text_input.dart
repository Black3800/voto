import 'package:flutter/material.dart';
import 'package:voto_mobile/utils/color.dart';

class SimpleTextInput extends StatefulWidget {
  final String? initialValue;
  final MaterialColor accentColor;
  final IconData? icon;
  final String hintText;
  final bool showEditIcon;
  const SimpleTextInput({Key? key, this.initialValue, this.accentColor = VotoColors.black, this.icon, this.hintText = 'Aa', this.showEditIcon = false }) : super(key: key);

  @override
  State<SimpleTextInput> createState() => _SimpleTextInputState();
}

class _SimpleTextInputState extends State<SimpleTextInput> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        initialValue: widget.initialValue,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: widget.accentColor,
        ),
        decoration: InputDecoration(
          prefixIcon: widget.icon != null ? Icon(
            widget.icon,
            color: widget.accentColor,
          ) : null,
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          hintText: widget.hintText,
          hintStyle: const TextStyle(color: Color(0xffc4c4c4)),
          fillColor: VotoColors.gray,
          filled: true,
          suffixIcon: widget.showEditIcon ? Icon(
            Icons.edit,
            color: widget.accentColor,
          ) : null,
        ),
      );
  }
}
