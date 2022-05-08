import 'package:flutter/material.dart';
import 'package:voto_mobile/utils/color.dart';

class PollRadio extends StatelessWidget {
  bool? isEditing;
  final String text;
  final String value;
  final String groupValue;
  final Function(String?)? onChanged;
    PollRadio(
      {Key? key,
      required this.text,
      required this.value,
      required this.groupValue,
      this.onChanged,
      this.isEditing})
      : super(key: key);

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
          child: Text(text, style: Theme.of(context).textTheme.bodyText1),
        ),
        secondary: Padding(
            padding: const EdgeInsets.only(right: 15),
            child: isEditing!
                ? IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: VotoColors.danger,
                    ),
                    onPressed: () {},
                  )
                : const SizedBox()),
        value: value,
        groupValue: groupValue,
        controlAffinity: ListTileControlAffinity.leading,
        onChanged: onChanged,
        contentPadding: const EdgeInsets.symmetric(horizontal: 0),
      ),
    );
  }
}
