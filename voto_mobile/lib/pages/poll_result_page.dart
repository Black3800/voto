import 'package:flutter/material.dart';
import 'package:voto_mobile/model/choice.dart';
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
  List<Choice> choices = [
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
    return VotoScaffold(
      useMenu: false,
      title: 'Result',
      titleContext: 'Integrated project II',
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
                    const PollHeader(),
                    const WinnerCard(),
                    const Heading('Full result'),
                    ...choices.map(
                      (e) => PollResultItem(
                          name: e.text ?? '', 
                          voteCount: e.voteCount ?? 0,
                          onTap: () {
                            showVoter(context, e);
                          }
                        )
                      ),
                  ][index],
                separatorBuilder: (context, index) => const SizedBox(height: 20),
                itemCount: choices.length + 3,
              ),
            ),
          ),
          const PollResultButton(),
        ],
      ),
    );
  }
}
