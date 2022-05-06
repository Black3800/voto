import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:voto_mobile/model/choice.dart';
import 'package:voto_mobile/model/items.dart';
import 'package:voto_mobile/model/persistent_state.dart';
import 'package:voto_mobile/widgets/random/random_task.dart';
import 'package:voto_mobile/widgets/random/start_button.dart';
import 'package:voto_mobile/widgets/voto_scaffold.dart';

class RandomPage extends StatefulWidget {
  const RandomPage({Key? key}) : super(key: key);

  @override
  State<RandomPage> createState() => _RandomPageState();
}

class _RandomPageState extends State<RandomPage> {
  List<Choice> _options = [];

  Future<void> _getOptions(BuildContext context) async {
    final args = ModalRoute.of(context)!.settings.arguments as Items;
    if(args.options == null) return;
    final String optionId = args.options ?? '';
    DatabaseReference ref = FirebaseDatabase.instance.ref('options/$optionId');
    ref.onValue.listen((DatabaseEvent event) {
      if(event.snapshot.exists) {
        _options = [];
        final data = event.snapshot.value as Map<dynamic, dynamic>;
        for (String key in data.keys) {
          Choice choice = Choice.fromJson(data[key]);
          choice.id = key;
          _options.add(choice);
        }
        WidgetsBinding.instance?.addPostFrameCallback((_) => setState(() {
          _options = List.from(_options);
        }));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      if(mounted) _getOptions(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Items;

    return Consumer<PersistentState>(builder: (context, appState, child) => 
      VotoScaffold(
        title: "Random",
        titleContext: appState.currentTeam?.name,
        useMenu: false,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 20.0,
                  left: 42.5,
                  right: 42.5
                ),
                child: ListView.separated(
                  itemBuilder: (context, index) => [
                    Text(
                      '${args.title}',
                      style: GoogleFonts.inter(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${args.description}',
                      style: GoogleFonts.inter(
                          fontSize: 14, fontWeight: FontWeight.normal),
                      textAlign: TextAlign.start,
                    ),
                    ..._options.map((e) => RandomTask(text: e.text ?? '')),
                  ][index],
                  separatorBuilder: (context, index) => const SizedBox(height: 15),
                  itemCount: _options.length + 2
                ),
              )
            ),
            StartButton(
              onPressed: () {
                print('stop');
              },
            ),
          ],
        ),
      ),
    );
  }
}
