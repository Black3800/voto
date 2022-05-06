import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voto_mobile/model/items.dart';
import 'package:voto_mobile/model/persistent_state.dart';
import 'package:voto_mobile/widgets/random/random_detail.dart';
import 'package:voto_mobile/widgets/random/random_task.dart';
import 'package:voto_mobile/widgets/random/start_button.dart';
import 'package:voto_mobile/widgets/voto_scaffold.dart';

class RandomPage extends StatelessWidget {
  const RandomPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Items;

    return Consumer<PersistentState>(builder: (context, appState, child) => 
      VotoScaffold(
        title: "Random",
        titleContext: appState.teamName,
        useMenu: false,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: const [
                RandomDetail(),
                RandomTask(),
                StartButton(),
              ],
            ),
          ],
        ),
      ),
    );
    // Container(
    //   child: Row(children: [
    //     const Text('Start random'),
    //     ElevatedButton(
    //         onPressed: () {
    //           Navigator.pop(context);
    //         },
    //         child: const Text('Back'),
    //         style: ButtonStyle(
    //             backgroundColor: MaterialStateProperty.resolveWith(
    //                 (states) => VotoColors.primary)))
    //   ]),
    // );
  }
}
