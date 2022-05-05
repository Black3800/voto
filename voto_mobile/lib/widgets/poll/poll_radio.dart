import 'package:flutter/material.dart';
import 'package:voto_mobile/utils/color.dart';

class PollRadio extends StatefulWidget {
  final String name;

  PollRadio({Key? key, required this.name}) : super(key: key);

  @override
  State<PollRadio> createState() => _PollRadioState();
}

class _PollRadioState extends State<PollRadio> {
  Object? val = -1;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      decoration: const BoxDecoration(
        color: Colors.transparent,
        border: Border(
          top: BorderSide(
            width: 1,
            color: Color(0xFFF2F4F8),
          ),
          bottom: BorderSide(
            width: 1,
            color: Color(0xFFF2F4F8),
          ),
        ),
      ),
      child: RadioListTile(
        title: Padding(
          padding: const EdgeInsets.only(left: 10),
          child:
              Text(widget.name, style: Theme.of(context).textTheme.bodyText1),
        ),
        value: 1,
        groupValue: val,
        controlAffinity: ListTileControlAffinity.leading,
        onChanged: (value) {
          setState(() {
            val = value;
          });
        },
        contentPadding: EdgeInsets.symmetric(horizontal: 0),
      ),
    );
  }
}
