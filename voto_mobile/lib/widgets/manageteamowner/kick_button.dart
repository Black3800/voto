import 'package:flutter/material.dart' hide OutlineButton;

import '../manageteam/outline_button.dart';

class KickButton extends StatelessWidget {
  final Function()? onPressed;
  const KickButton({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlineButton(
        text: "Kick",
        width: 40.0,
        height: 25.0,
        fontSize: 12.0,
        onPressed: onPressed
    );
  }
}
