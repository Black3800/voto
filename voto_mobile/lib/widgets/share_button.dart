import 'package:flutter/material.dart';
import 'package:voto_mobile/utils/color.dart';
import 'package:voto_mobile/widgets/wide_button.dart';

class ShareButton extends StatefulWidget {
  final String shareText;
  final String saveText;
  final bool isSharing;
  final bool isSaving;
  final bool useToggle;
  final Function()? onShare;
  final Function()? onSave;
  final double height;
  final double horizontalPadding;
  const ShareButton(
      {Key? key,
      required this.shareText,
      this.saveText = 'Save result',
      this.isSharing = false,
      this.isSaving = false,
      this.useToggle = false,
      required this.onShare,
      required this.onSave,
      this.height = 100,
      this.horizontalPadding = 50})
      : super(key: key);

  @override
  State<ShareButton> createState() => _ShareButtonState();
}

class _ShareButtonState extends State<ShareButton> {
  bool _isSaving = false;
  bool _isSharing = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      padding: EdgeInsets.symmetric(horizontal: widget.horizontalPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: WideButton(
              text: widget.saveText,
              onPressed: () {
                if (widget.useToggle) setState(() => _isSaving = !_isSaving);
                widget.onSave?.call();
              },
              foregroundColor: VotoColors.indigo,
              backgroundColor: widget.isSaving ? VotoColors.gray : VotoColors.white,
              isLoading: widget.useToggle ? _isSaving : widget.isSaving,
              isBold: false,
            )
          ),
          const SizedBox(width: 20.0),
          Expanded(
            child: WideButton(
              text: widget.shareText,
              onPressed: () {
                if (widget.useToggle) setState(() => _isSharing = !_isSharing);
                widget.onShare?.call();
              },
              isLoading: widget.useToggle ? _isSharing : widget.isSharing
            )
          ),
        ],
      ),
    );
  }
}
