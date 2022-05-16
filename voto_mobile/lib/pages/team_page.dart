import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:voto_mobile/model/persistent_state.dart';
import 'package:voto_mobile/utils/color.dart';
import 'package:voto_mobile/widgets/rich_button.dart';
import 'package:voto_mobile/widgets/team/item_card.dart';
import 'package:voto_mobile/widgets/voto_scaffold.dart';

class TeamPage extends StatefulWidget {
  const TeamPage({Key? key}) : super(key: key);

  @override
  State<TeamPage> createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {

  String? teamId;
  late DatabaseReference itemsRef;
  final ScrollController _scrollController = ScrollController();
  bool isFirstRender = true;
  final Map<String, bool> cardBuilt = {};

  void _scrollDown(String id, int totalCard) {
    if (!isFirstRender) return;
    cardBuilt[id] = true;
    print('${cardBuilt.length} == $totalCard');
    if (cardBuilt.length >= totalCard) {
      Timer(const Duration(milliseconds: 100), () {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
        print(cardBuilt);
        isFirstRender = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    teamId = Provider.of<PersistentState>(context, listen: false).currentTeam?.id;
    itemsRef = FirebaseDatabase.instance.ref('teams/$teamId/items');
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PersistentState>(builder: (context, appState, child) => 
      VotoScaffold(
        useMenu: false,
        useSetting: true,
        title: '${appState.currentTeam?.name}',
        body: Column(
          children: [
            appState.currentUser!.uid == appState.currentTeam!.owner
                      ? Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: RichButton(
                              text: 'Create new poll/random',
                              icon: Icons.add,
                              accentColor: VotoColors.indigo,
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, '/create_item_page');
                              },
                              width: 250))
                      : Container(),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  top: (appState.currentUser!.uid == appState.currentTeam!.owner) ? 0 : 20
                ),
                child: StreamBuilder(
                  stream: itemsRef.onValue,
                  builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                                child: SizedBox(
                                    width: 32,
                                    height: 32,
                                    child: CircularProgressIndicator()),
                              );
                    }
                    if (snapshot.connectionState == ConnectionState.active && snapshot.hasData) {
                      Map? _currentItems = snapshot.data?.snapshot.value as Map<dynamic, dynamic>?;
                      if(_currentItems != null) {
                        _currentItems = _currentItems.map((key, value) => MapEntry(key, DateTime.parse(value)));
                        final _itemsList = _currentItems.keys.toList();
                        _itemsList.sort((a, b) => _currentItems![a].compareTo(_currentItems[b]));
                        cardBuilt.clear();
                        return SingleChildScrollView(
                          controller: _scrollController,
                          child: Column(
                            children: [..._itemsList.map((e) => ItemCard(
                                    id: e,
                                    onBuildCompleted: () => _scrollDown(e, _itemsList.length),
                                  ))]
                          ),
                        );
                      } else {
                        return Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(20),
                                  child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.celebration,
                                          color: VotoColors.magenta,
                                          size: 64,
                                        ),
                                        const SizedBox(height: 24),
                                        Text('Welcome to your team!',
                                            style: GoogleFonts.inter(
                                                fontSize: 18,
                                                color: VotoColors.black)),
                                        Text('Start by creating some items',
                                            style: GoogleFonts.inter(
                                                fontSize: 16,
                                                color: VotoColors.black.shade400)),
                                      ]),
                                );
                      }
                    }
                    return Container();
                  }
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}
