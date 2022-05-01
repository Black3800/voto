import 'package:flutter/material.dart';
import 'package:voto_mobile/utils/color.dart';
import 'package:voto_mobile/widgets/wide_button.dart';

class ToggleSwitch extends StatelessWidget {
  final bool left;
  final String textLeft;
  final String textRight;
  final MaterialColor color;
  final Function()? onChanged;
  const ToggleSwitch({ Key? key, this.left = true, this.color = VotoColors.magenta, required this.textLeft, required this.textRight, required this.onChanged }) : super(key: key);

  Widget activeButton(text) =>  WideButton(
                                  text: text,
                                  backgroundColor: color,
                                  isElevated: true,
                                  onPressed: () {}
                                );

  Widget inactiveButton(text) =>  WideButton(
                                    text: text,
                                    foregroundColor: color,
                                    backgroundColor: VotoColors.gray,
                                    isElevated: false,
                                    isBold: false,
                                    onPressed: onChanged
                                  );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: VotoColors.gray,
        borderRadius: BorderRadius.circular(20.0)
      ),
      child: Row(
        children: [
          Expanded(
            child: left ? activeButton(textLeft) : inactiveButton(textLeft)
          ),
          Expanded(
            child: left ? inactiveButton(textRight) : activeButton(textRight)
          ),
      ]),
    );
  }
}