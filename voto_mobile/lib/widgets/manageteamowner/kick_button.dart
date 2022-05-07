import 'package:flutter/material.dart';
import 'package:voto_mobile/utils/color.dart';

import '../manageteam/outlinebutton.dart';

class KickButton extends StatelessWidget {
  const KickButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Outline_button(
        text: "Kick",
        width: 40.0,
        height: 25.0,
        fontSize: 12.0,
        onPressed: () => showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title:
                    const Text('Are you sure you want to delete this member?'),
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
            ));
  }
}
