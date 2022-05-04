import 'package:flutter/material.dart';
import 'package:voto_mobile/utils/color.dart';
import '../manageteam/outlinebutton.dart';

class DeleteTeamButton extends StatelessWidget {
  const DeleteTeamButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void deleteTeam() {
      Navigator.pop(context);
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Outline_button(text: "Delete team"),
    );
  }
}
