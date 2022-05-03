import 'package:flutter/material.dart';
import 'package:voto_mobile/utils/color.dart';

import '../manageteam/outlinebutton.dart';

class KickButton extends StatelessWidget {
  const KickButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20),
      child: Outline_button("Kick", 30, 12, 10),
    );
  }
}
