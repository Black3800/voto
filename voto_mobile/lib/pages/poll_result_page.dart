import 'package:flutter/material.dart';

import 'package:voto_mobile/widgets/poll/poll_header.dart';
import 'package:voto_mobile/widgets/pollresult/poll_result_body.dart';
import 'package:voto_mobile/widgets/pollresult/poll_result_button.dart';
import 'package:voto_mobile/widgets/voto_scaffold.dart';

class PollResultPage extends StatelessWidget {
  const PollResultPage({Key? key}) : super(key: key);

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
              padding:
                  const EdgeInsets.only(top: 20.0, left: 42.5, right: 42.5),
              child: ListView(children: const [
                PollHeader(),
                SizedBox(height: 20.0),
                PollResultBody(),
              ]),
            ),
          ),
          const PollResultButton(),
        ],
      ),
    );
  }
}
