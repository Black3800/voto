import 'package:flutter/material.dart';
import 'package:voto_mobile/widgets/wide_button.dart';

class StartButton extends StatelessWidget {
  final Function()? onPressed;
  const StartButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 32.5,
        horizontal: 42.5
      ),
      child: WideButton(
        text: 'Stop',
        onPressed: onPressed,
      ),
    );
  }
}
