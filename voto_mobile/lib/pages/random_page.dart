import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:voto_mobile/model/choice.dart';
import 'package:voto_mobile/model/persistent_state.dart';
import 'package:voto_mobile/utils/color.dart';
import 'package:voto_mobile/widgets/random/random_body.dart';
import 'package:voto_mobile/widgets/random/start_button.dart';
import 'package:voto_mobile/widgets/voto_scaffold.dart';

class RandomPage extends StatefulWidget {
  const RandomPage({Key? key}) : super(key: key);

  @override
  State<RandomPage> createState() => _RandomPageState();
}

class _RandomPageState extends State<RandomPage> {

  String? itemId;
  String? teamId;
  late DatabaseReference _optionsRef;

  Future<void> _stopRandom(String itemId, String type) async {
    final snapshot = await _optionsRef.child('choices').get();
    if (snapshot.exists) {
      final data = snapshot.value as Map;
      final choices = data.keys.toList();
      if (type == 'lucky') {
        choices.shuffle();
        await _optionsRef.child('choices/${choices.first}').update({'win': true});
        await _optionsRef.child('winner').update({choices.first: true});
      } else {
        final memberSnapshot = await FirebaseDatabase.instance.ref('teams/$teamId/members').get();
        if (memberSnapshot.exists) {
          final memberData = memberSnapshot.value as Map;
          final members = memberData.keys.toList();
          final Map<String,String> result = {};
          int i = 0;
          while (i < choices.length) {
            if (i % members.length == 0) {
              members.shuffle();
            }
            result[choices[i]] = members[i % members.length];
            await _optionsRef.child('choices/${choices[i]}').update({'assignee': members[i % members.length]});
            i++;
          }
          await _optionsRef.child('winner').update(result);
        }
      }
      await FirebaseDatabase.instance.ref('items/$itemId').update({
          'closed': true,
          'last_modified': DateTime.now().toIso8601String()
        });
    }
  }

  Future<bool> _handlePop() async {
    Provider.of<PersistentState>(context, listen: false).disposeItem();
    return Future.value(true);
  }

  @override
  void initState() {
    super.initState();
    itemId = Provider.of<PersistentState>(context, listen: false).currentItem!.id;
    teamId = Provider.of<PersistentState>(context, listen: false).currentTeam!.id;
    _optionsRef = FirebaseDatabase.instance.ref('options/$itemId');
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PersistentState>(builder: (context, appState, child) => 
      VotoScaffold(
        title: "Random",
        titleContext: appState.currentTeam?.name,
        useMenu: false,
        onWillPop: _handlePop,
        body: StreamBuilder(
          stream: _optionsRef.onValue,
          builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: SizedBox(
                    width: 32, height: 32, child: CircularProgressIndicator()),
              );
            } else if (snapshot.connectionState == ConnectionState.active && snapshot.hasData) {
              final data = snapshot.data!.snapshot.value as Map?;
              if (data == null) {
                return Padding(
                  padding: const EdgeInsets.only(
                    top: 20.0,
                    left: 42.5,
                    right: 42.5
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${appState.currentItem!.title}',
                        style: GoogleFonts.inter(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 15.0),
                      Text(
                        '${appState.currentItem!.description}',
                        style: GoogleFonts.inter(
                            fontSize: 14, fontWeight: FontWeight.normal),
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(height: 15.0),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: VotoColors.gray,
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                            mainAxisAlignment:
                                MainAxisAlignment.center,
                            children: [
                              Text('Empty',
                                  style: GoogleFonts.inter(
                                      fontSize: 18,
                                      color:
                                          VotoColors.black.shade300)),
                              Text('Add some options',
                                  style: GoogleFonts.inter(
                                      color:
                                          VotoColors.black.shade300))
                            ]),
                      )
                    ]
                  )
                );
              }
              bool isClosed = data['winner'] != null;
              List<Choice> choices = [];
              for (final choice in data['choices'].entries) {
                final _choice = Choice.fromJson(choice.value);
                _choice.id = choice.key;
                choices.add(_choice);
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 20.0,
                        left: 42.5,
                        right: 42.5
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${appState.currentItem!.title}',
                            style: GoogleFonts.inter(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 15.0),
                          Text(
                            '${appState.currentItem!.description}',
                            style: GoogleFonts.inter(
                                fontSize: 14, fontWeight: FontWeight.normal),
                            textAlign: TextAlign.start,
                          ),
                          const SizedBox(height: 15.0),
                          RandomBody(
                            type: appState.currentItem!.randomType!,
                            choices: choices,
                            isClosed: isClosed
                          ),
                        ]
                      ),
                    )
                  ),
                  if (!isClosed && appState.currentUser!.uid == appState.currentTeam!.owner)
                    StartButton(
                      onPressed: () => _stopRandom(appState.currentItem!.id!, appState.currentItem!.randomType!),
                    ),
                ],
              );
            }
            return Container();
          }
        ),
      ),
    );
  }
}
