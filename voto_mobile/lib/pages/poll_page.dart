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
        Container(
          height: 131,
          padding: const EdgeInsets.only(left: 42.5, right: 42.5),
          child: const PollHeader(),
        ),
        Expanded(
          flex: 5,
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(left: 42.5, right: 42.5, top: 0),
            child: const PollBody(),
          ),
        ),
        const Expanded(flex: 1, child: PollButton()),
      ]),
    );
  }
}
