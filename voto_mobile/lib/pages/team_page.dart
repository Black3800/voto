import 'package:flutter/material.dart';
import 'package:voto_mobile/model/items.dart';
import 'package:voto_mobile/model/poll_settings.dart';
import 'package:voto_mobile/model/team.dart';
import 'package:voto_mobile/utils/color.dart';
import 'package:voto_mobile/widgets/rich_button.dart';
import 'package:voto_mobile/widgets/team/poll_card.dart';
import 'package:voto_mobile/widgets/team/random_card.dart';
import 'package:voto_mobile/widgets/team/result_card.dart';
import 'package:voto_mobile/widgets/voto_scaffold.dart';

class TeamPage extends StatefulWidget {
  const TeamPage({Key? key}) : super(key: key);

  @override
  State<TeamPage> createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Team;

    return VotoScaffold(
      useMenu: false,
      useSetting: true,
      title: args.name,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: RichButton(
              text: 'Create new poll/random',
              icon: Icons.add,
              accentColor: VotoColors.indigo,
              onPressed: () {
                Navigator.pushNamed(context, '/create_item_page');
              },
              width: 250
            )
          ),
          Expanded(
            child: ListView(
              children: [
                RandomCard(
                  item: Items(
                    title: 'Random food',
                    description: 'Let\'s random food for dinner',
                    options: 'bbccdd9999'
                  ),
                ),
                PollCard(
                  item: Items(
                    title: 'Vote for app theme (single)',
                    description: 'Let\'s vote for the main theme of our app',
                    pollSettings: PollSettings(closeDate: DateTime.now().add(const Duration(days: 7)))
                  )
                ),
                PollCard(
                  item: Items(
                    title: 'Vote for app theme (multiple)',
                    description: 'Let\'s vote for the main theme of our app',
                    pollSettings: PollSettings(
                      closeDate: DateTime.now().add(const Duration(days: 7)),
                      multipleVote: true
                    ),
                  )
                ),
                ResultCard(
                    title: 'Vote project topic',
                    closeDate: '22 April 2022',
                    description: 'Winner: Vo-To'),
                SizedBox(height: 50.0)
              ],
            ),
          )
        ],
      ),
    );
  }
}
