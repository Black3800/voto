import 'package:flutter/material.dart';
import 'package:voto_mobile/utils/color.dart';

import '../manageteam/outlinebutton.dart';

class KickButton extends StatelessWidget {
  final Function()? onPressed;
  const KickButton({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Outline_button(
        text: "Kick",
        width: 40.0,
        height: 25.0,
        fontSize: 12.0,
        onPressed: onPressed
    );
  }
}
