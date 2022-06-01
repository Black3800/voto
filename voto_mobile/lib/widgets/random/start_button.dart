import 'package:flutter/material.dart';
import 'package:voto_mobile/widgets/wide_button.dart';

class StartButton extends StatefulWidget {
  final Function()? onPressed;
  final bool disabled;
  const StartButton({
    Key? key,
    required this.onPressed,
    this.disabled = false
  }) : super(key: key);

  @override
  State<StartButton> createState() => _StartButtonState();
}

class _StartButtonState extends State<StartButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return _isPressed
        ? Container()
        : Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 32.5, horizontal: 42.5),
            child: WideButton(
                text: 'Stop',
                onPressed: () {
                  setState(() => _isPressed = true);
                  widget.onPressed?.call();
                },
                disabled: widget.disabled),
          );
  }
}
