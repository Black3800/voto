import 'package:flutter/material.dart';
import 'package:voto_mobile/utils/color.dart';
import 'package:voto_mobile/widgets/wide_button.dart';

class ShareButton extends StatelessWidget {
  final String shareText;
  final String saveText;
  final Function()? onShare;
  final Function()? onSave;
  final double height;
  final double horizontalPadding;
  const ShareButton(
      {Key? key,
      required this.shareText,
      this.saveText = 'Save to device',
      required this.onShare,
      required this.onSave,
      this.height = 100,
      this.horizontalPadding = 50})
      : super(key: key);

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
            text: saveText,
            onPressed: onSave,
            foregroundColor: VotoColors.indigo,
            backgroundColor: VotoColors.gray,
            isElevated: false,
          )),
          const SizedBox(width: 20.0),
          Expanded(child: WideButton(text: shareText, onPressed: onShare)),
        ],
      ),
    );
  }
}
