import 'package:flutter/material.dart';
import 'package:voto_mobile/utils/color.dart';
import 'package:voto_mobile/widgets/wide_button.dart';

class ConfirmButton extends StatelessWidget {
  final String confirmText;
  final String cancelText;
  final Function()? onConfirm;
  final Function()? onCancel;
  final double height;
  final double horizontalPadding;
  final bool disabled;
  const ConfirmButton({
    Key? key,
    required this.confirmText,
    this.cancelText = 'Cancel',
    required this.onConfirm,
    required this.onCancel,
    this.height = 100,
    this.horizontalPadding = 50,
    this.disabled = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print('disabled: $disabled');
    return Container(
      height: height,
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: WideButton(
              text: cancelText,
              onPressed: onCancel,
              foregroundColor: VotoColors.indigo,
              backgroundColor: VotoColors.gray,
              isElevated: false,
              isBold: false,
            )),
          const SizedBox(width: 20.0),
          Expanded(
            child: WideButton(
              text: confirmText,
              onPressed: onConfirm,
              disabled: disabled,
            )
          ),
        ],
      ),
    );
  }
}