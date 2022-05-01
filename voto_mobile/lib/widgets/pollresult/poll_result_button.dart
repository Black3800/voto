import 'package:flutter/material.dart';
import 'package:voto_mobile/widgets/share_button.dart';

class PollResultButton extends StatelessWidget {
  const PollResultButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void shareResult() {
      Navigator.pushNamed(context, '/poll_result_page');
    }

    void saveResultToDevice() {
      Navigator.pushNamed(context, '/poll_result_page');
    }

    return ShareButton(
        shareText: 'Share', onShare: shareResult, onSave: saveResultToDevice);
  }
}
