import 'package:flutter/material.dart';
import 'package:voto_mobile/utils/color.dart';

class PollRadio extends StatelessWidget {
  final String text;
  final int value;
  final int groupValue;
  final Function(int?)? onChanged;
  const PollRadio({
    Key? key,
    required this.text,
    required this.value,
    required this.groupValue,
    this.onChanged
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      decoration: const BoxDecoration(
        color: Colors.transparent,
        border: Border(
          top: BorderSide(
            width: 1,
            color: VotoColors.gray,
          ),
          bottom: BorderSide(
            width: 1,
            color: VotoColors.gray,
          ),
        ),
      ),
      child: RadioListTile(
        title: Padding(
          padding: const EdgeInsets.only(left: 10),
          child:
              Text(text, style: Theme.of(context).textTheme.bodyText1),
        ),
        value: value,
        groupValue: groupValue,
        controlAffinity: ListTileControlAffinity.leading,
        onChanged: onChanged,
        contentPadding: const EdgeInsets.symmetric(horizontal: 0),
      ),
    );
  }
}