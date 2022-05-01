import 'package:flutter/material.dart';
import 'package:voto_mobile/utils/color.dart';
import 'package:voto_mobile/widgets/pollresult/poll_result_item.dart';
import 'package:voto_mobile/widgets/winner_card.dart';
import 'package:google_fonts/google_fonts.dart';

class PollResultBody extends StatefulWidget {
  const PollResultBody({Key? key}) : super(key: key);

  @override
  State<PollResultBody> createState() => _PollResultBodyState();
}

class _PollResultBodyState extends State<PollResultBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const WinnerCard(),
        fullResultText(),
        PollResultItem(onTap: showVoter, name: 'Salad', voteCount: 23),
        PollResultItem(onTap: showVoter, name: 'Pizza', voteCount: 7),
        PollResultItem(onTap: showVoter, name: 'Salad', voteCount: 5),
      ],
    );
  }

  void showVoter() {
    Navigator.pushNamed(context, '/poll_result_page');
  }

  Widget fullResultText() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Text(
        'Full result',
        style: GoogleFonts.inter(
          color: VotoColors.black,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
