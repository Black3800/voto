import 'package:flutter/material.dart';
import 'package:voto_mobile/utils/color.dart';
import 'package:voto_mobile/widgets/random/random_detail.dart';
import 'package:voto_mobile/widgets/random/random_task.dart';
import 'package:voto_mobile/widgets/random/start_button.dart';
import 'package:voto_mobile/widgets/randomresult/random_result_button.dart';
import 'package:voto_mobile/widgets/share_button.dart';
import 'package:voto_mobile/widgets/voto_scaffold.dart';

class RandomResultPage extends StatelessWidget {
  const RandomResultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VotoScaffold(
      title: "Random",
      titleContext: "GEN352",
      useMenu: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ListView(
              children: const [
                RandomDetail(),
                RandomTask(),
              ],
            )),
          ShareButton(shareText: 'Share', onShare: () {}, onSave: () {}),
        ]
      ),
    );
  }
}
