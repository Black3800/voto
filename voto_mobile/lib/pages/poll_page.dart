import 'package:flutter/material.dart';
import 'package:voto_mobile/widgets/poll/poll_body.dart';
import 'package:voto_mobile/widgets/poll/poll_button.dart';
import 'package:voto_mobile/widgets/poll/poll_header.dart';
import 'package:voto_mobile/widgets/voto_scaffold.dart';

class PollPage extends StatelessWidget {
  const PollPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VotoScaffold(
      useMenu: false,
      title: 'Vote',
      titleContext: 'Integrated project II',
      body: Column(children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 20.0,
              left: 42.5,
              right: 42.5
            ),
            child: ListView(
              children: const [
                PollHeader(),
                SizedBox(height: 20.0),
                PollBody(),
              ]),
          ),
        ),
        const PollButton(),
      ]),
    );
  }
}
