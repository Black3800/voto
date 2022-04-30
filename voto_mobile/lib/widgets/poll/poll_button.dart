import 'package:flutter/material.dart';
import 'package:voto_mobile/widgets/confirm_button.dart';

class PollButton extends StatelessWidget {
  const PollButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    void submitVote() {
      Navigator.pop(context);
    }

    return ConfirmButton(
      confirmText: 'Vote',
      onConfirm: submitVote,
      onCancel: submitVote
    );
  }

  // Widget pollVoteButton(context) {
  //   return ElevatedButton(
  //     style: ElevatedButton.styleFrom(
  //       onSurface: (VotoColors.indigo),
  //       fixedSize: const Size(132, 35),
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(20),
  //       ),
  //     ),
  //     onPressed: () {
  //       Navigator.pushNamed(context, '/poll_result_page');
  //     },
  //     child: const Text(
  //       'Vote',
  //       style: TextStyle(
  //         color: Colors.white,
  //         fontWeight: FontWeight.bold,
  //       ),
  //     ),
  //   );
  // }

  // Widget pollCancelButton(context) {
  //   return ElevatedButton(
  //     style: ElevatedButton.styleFrom(
  //       primary: const Color(0xFFF2F4F8),
  //       fixedSize: const Size(132, 35),
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(20),
  //       ),
  //     ),
  //     onPressed: () {
  //       Navigator.pushNamed(context, '/team_page');
  //     },
  //     child: const Text(
  //       'Cancle',
  //       style: TextStyle(color: VotoColors.indigo, fontWeight: FontWeight.bold),
  //     ),
  //   );
  // }
}
