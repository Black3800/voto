import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voto_mobile/model/items.dart';
import 'package:voto_mobile/model/persistent_state.dart';
import 'package:voto_mobile/widgets/poll/poll_body.dart';
import 'package:voto_mobile/widgets/poll/poll_button.dart';
import 'package:voto_mobile/widgets/poll/poll_header.dart';
import 'package:voto_mobile/widgets/voto_scaffold.dart';

class PollPage extends StatelessWidget {
  const PollPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Items;

    return Consumer<PersistentState>(builder: (context, appState, child) => 
      VotoScaffold(
        useMenu: false,
        title: 'Vote',
        titleContext: appState.currentTeam?.name,
        body: Column(children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 20.0,
                left: 42.5,
                right: 42.5
              ),
              child: ListView(
                children: [
                  const PollHeader(),
                  const SizedBox(height: 20.0),
                  PollBody(isMultipleValue: args.pollSettings?.multipleVote ?? false),
                ]),
            ),
          ),
          const PollButton(),
        ]),
      )
    );
  }
}
