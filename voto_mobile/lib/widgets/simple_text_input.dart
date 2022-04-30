import 'package:flutter/material.dart';
import 'package:voto_mobile/utils/color.dart';

class SimpleTextInput extends StatefulWidget {
  final String? initialValue;
  final MaterialColor accentColor;
  final IconData? icon;
  final String hintText;
  const SimpleTextInput({Key? key, this.initialValue, this.accentColor = VotoColors.black, this.icon, this.hintText = 'Aa' }) : super(key: key);

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
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: widget.accentColor,
        ),
        onChanged: (value) {
          setState(() {});
        },
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
