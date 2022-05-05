import 'package:flutter/material.dart';
import 'package:voto_mobile/utils/color.dart';

class Heading extends StatelessWidget {
  final String text;
  const Heading(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: Theme.of(context)
            .textTheme
            .headline3!
            .merge(const TextStyle(color: VotoColors.black)));
  }
}