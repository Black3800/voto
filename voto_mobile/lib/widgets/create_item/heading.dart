import 'package:flutter/material.dart';
import 'package:voto_mobile/utils/color.dart';

class Heading extends StatelessWidget {
  final String text;
  final BuildContext? context;
  const Heading(this.text, {Key? key, this.context}) : super(key: key);

  @override
  Widget build(BuildContext _context) {
    print('${Theme.of(context ?? _context).textTheme.headline3?.fontSize}');
    return Text(text,
        style: Theme.of(context ?? _context)
            .textTheme
            .headline3
            ?.merge(const TextStyle(color: VotoColors.black)));
  }
}