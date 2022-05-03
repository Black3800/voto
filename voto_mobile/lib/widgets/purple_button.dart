import 'package:flutter/material.dart';
import 'package:voto_mobile/utils/color.dart';

class Purple_button extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        onSurface: (VotoColors.indigo),
        fixedSize: const Size(134, 35),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onPressed: () {},
      child: const Text(
        'Copy link to team',
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
        textAlign: TextAlign.center,
      ),
    );
  }
}
