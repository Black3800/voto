import 'package:flutter/material.dart';
import 'package:voto_mobile/utils/color.dart';

class PollButton extends StatelessWidget {
  const PollButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _deviceHeight = MediaQuery.of(context).size.height;
    double _deviceWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: _deviceWidth,
      height: _deviceHeight * 0.15,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [pollCancelButton(context), pollVoteButton(context)],
      ),
    );
  }

  Widget pollVoteButton(context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        onSurface: (VotoColors.indigo),
        fixedSize: const Size(132, 35),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onPressed: () {
        Navigator.pushNamed(context, '/poll_result_page');
      },
      child: const Text(
        'Vote',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget pollCancelButton(context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: const Color(0xFFF2F4F8),
        fixedSize: const Size(132, 35),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onPressed: () {
        Navigator.pushNamed(context, '/team_page');
      },
      child: const Text(
        'Cancle',
        style: TextStyle(color: VotoColors.indigo, fontWeight: FontWeight.bold),
      ),
    );
  }
}
