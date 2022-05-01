import 'package:flutter/material.dart';
import 'package:voto_mobile/utils/color.dart';

class SimpleCheckbox extends StatelessWidget {
  final String text;
  final bool isChecked;
  final MaterialColor color;
  final Function()? onChanged;
  const SimpleCheckbox({ Key? key, required this.text, required this.isChecked, required this.onChanged, this.color = VotoColors.indigo }) : super(key: key);

  Widget checkedBox() =>  Container(
                            width: 25.0,
                            height: 25.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              color: color,
                            ),
                            child: const Icon(
                              Icons.check,
                              color: VotoColors.white,
                            ),
                          );

  Widget uncheckedBox() =>  Container(
                              width: 25.0,
                              height: 25.0,
                              decoration: BoxDecoration(
                                border: Border.all(color: color),
                                borderRadius: BorderRadius.circular(5.0),
                                color: VotoColors.white,
                              ),
                            );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onChanged,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          isChecked ? checkedBox() : uncheckedBox(),
          const SizedBox(width: 10.0),
          Expanded(child: Text(text, style: Theme.of(context).textTheme.bodyText1,))
        ]),
      splashFactory: NoSplash.splashFactory,
    );
  }
}