import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:voto_mobile/model/choice.dart';
import 'package:voto_mobile/model/items.dart';
import 'package:voto_mobile/model/persistent_state.dart';
import 'package:voto_mobile/widgets/create_item/heading.dart';
import 'package:voto_mobile/widgets/poll/poll_header.dart';
import 'package:voto_mobile/widgets/pollresult/poll_result_button.dart';
import 'package:voto_mobile/widgets/pollresult/poll_result_item.dart';
import 'package:voto_mobile/widgets/pollresult/voter_dialog.dart';
import 'package:voto_mobile/widgets/voto_scaffold.dart';
import 'package:voto_mobile/widgets/winner_card.dart';

class PollResultPage extends StatefulWidget {
  const PollResultPage({Key? key}) : super(key: key);

  @override
  State<PollResultPage> createState() => _PollResultPageState();
}

class _PollResultPageState extends State<PollResultPage> {
  int totalVote = 73;
  int winnerCount = 2;

  List<Choice> _choices = [
    Choice(text: 'KFC', voteCount: 38),
    Choice(text: 'Salad', voteCount: 23),
    Choice(text: 'Pizza', voteCount: 7),
    Choice(text: 'Bonchon', voteCount: 5),
  ];
  
  void showVoter(BuildContext context, Choice choice) {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.0))),
      context: context,
      builder: (_) {
        return VoterDialog(choice: choice);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Items;
    final bool _showVoter = !(args.pollSettings?.anonymousVote ?? false);
    /***
     * anonymousVote = true --> showVoter = false
     * anonymousVote = false --> showVoter = true
     */

    return Consumer<PersistentState>(builder: (context, appState, child) => 
      VotoScaffold(
        useMenu: false,
        title: 'Result',
        titleContext: appState.currentTeam?.name,
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 20.0,
                  left: 42.5,
                  right: 42.5,
                ),
                child: ListView.separated(
                  itemBuilder: (context, index) => [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${args.title}',
                            style: GoogleFonts.inter(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            'Closed on ${args.pollSettings?.closeDateFormatted}',
                            style: GoogleFonts.inter(
                                fontSize: 12, fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                      Text(
                        '${args.description}',
                        style: GoogleFonts.inter(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                      WinnerCard(
                        winners: _choices.sublist(0, winnerCount)
                      ),
                      const Heading('Full result'),
                      ..._choices.map(
                        (e) => PollResultItem(
                            name: e.text ?? '',
                            voteCount: e.voteCount ?? 0,
                            totalVote: totalVote,
                            showVoter: _showVoter,
                            onTap: _showVoter ? () {
                              showVoter(context, e);
                            } : null
                          )
                        ),
                    ][index],
                  separatorBuilder: (context, index) => const SizedBox(height: 20),
                  itemCount: _choices.length + 4,
                ),
              ),
            ),
            const PollResultButton(),
          ],
        ),
      )
    );
  }
}
