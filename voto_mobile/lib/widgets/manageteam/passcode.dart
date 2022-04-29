import 'package:flutter/material.dart';
import 'package:voto_mobile/widgets/manageteam/passcodefiled.dart';

class Pass extends StatelessWidget {
  const Pass({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 28),
      child: Row(children: [
        Passcode(num: "3"),
        Passcode(num: "3"),
        Passcode(num: "3"),
        Passcode(num: "3"),
      ]),
    );
  }
}
