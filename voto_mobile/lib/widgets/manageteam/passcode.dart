import 'package:flutter/material.dart';
import 'package:voto_mobile/widgets/manageteam/passcodefiled.dart';

class Pass extends StatelessWidget {
  bool isEditing;

  Pass({required this.isEditing, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int passNumber1 = 1;
    int passNumber2 = 2;
    int passNumber3 = 3;
    int passNumber4 = 4;

    return Container(
      padding: const EdgeInsets.only(left: 28),
      child: Row(children: [
        Passcode(
          passNumber: passNumber1,
          isEditing: isEditing,
        ),
        Passcode(
          passNumber: passNumber2,
          isEditing: isEditing,
        ),
        Passcode(
          passNumber: passNumber3,
          isEditing: isEditing,
        ),
        Passcode(
          passNumber: passNumber4,
          isEditing: isEditing,
        ),
      ]),
    );
  }
}
