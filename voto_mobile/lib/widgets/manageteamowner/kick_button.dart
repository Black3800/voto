import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voto_mobile/utils/color.dart';

import '../manageteam/outlinebutton.dart';

class KickButton extends StatelessWidget {
  const KickButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20),
      // child: Outline_button("Kick", 30, 12, 10),
      child: KickButtonn(),
    );
  }
}

class KickButtonn extends StatelessWidget {
  const KickButtonn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Are you sure you want to delete this member?'),
          content: const Text(
              'If you kick this member,They will not belong to this group.'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      ),
      child: Outline_button("Kick", 30, 12, 10),
    );
  }
}
