import 'package:flutter/material.dart';
import 'package:voto_mobile/utils/color.dart';

class SimpleTextInput extends StatefulWidget {
  final String? initialValue;
  final MaterialColor accentColor;
  final IconData? icon;
  final String hintText;
  final bool multiline;
  const SimpleTextInput({Key? key, this.initialValue, this.accentColor = VotoColors.black, this.icon, this.hintText = 'Aa', this.multiline = false }) : super(key: key);

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: _controller,
        initialValue: widget.initialValue,
        minLines: widget.multiline ? 4 : 1,
        maxLines: widget.multiline ? null : 1,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: widget.accentColor,
        ),
        onChanged: (value) {
          setState(() {});
        },
        decoration: InputDecoration(
          isDense: true,
          contentPadding: const EdgeInsets.all(16.0),
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
          suffixIcon: _controller.text.isNotEmpty ? InkWell(
            child: Icon(
              Icons.close,
              color: widget.accentColor,
            ),
            onTap: () {
              _controller.clear();
              setState(() {});
            },
          ) : null, 
        ),
      );
  }
}
