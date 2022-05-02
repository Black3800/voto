import 'package:flutter/material.dart';
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
    return VotoScaffold(
      useMenu: false,
      useSetting: true,
      title: 'Integrated Project II',
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
              children: const [
                RandomCard(
                    title: 'Random food',
                    description: 'Let\'s random food for dinner'),
                // RandomCard(
                //     title: 'Random food',
                //     description: 'Let\'s random food for dinner',
                //     showStartRandom: false,),
                PollCard(
                  title: 'Vote for theme app',
                  closeDate: '22 April 2022',
                  description: 'Let\'s vote for the main theme of our app'),
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
