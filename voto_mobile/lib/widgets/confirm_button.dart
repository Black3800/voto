import 'package:flutter/material.dart';
import 'package:voto_mobile/utils/color.dart';
import 'package:voto_mobile/widgets/wide_button.dart';

class ConfirmButton extends StatelessWidget {
  final Function()? onConfirm;
  final Function()? onCancel;
  final double height;
  final double horizontalPadding;
  const ConfirmButton({ Key? key, required this.onConfirm, required this.onCancel, this.height = 100, this.horizontalPadding = 50 }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: WideButton(
              text: 'Cancel',
              onPressed: onCancel,
              foregroundColor: VotoColors.indigo,
              backgroundColor: VotoColors.gray,
              isElevated: false,
            )),
          const SizedBox(width: 20.0),
          Expanded(child: WideButton(text: 'Vote', onPressed: onConfirm)),
        ],
      ),
    );
  }
}