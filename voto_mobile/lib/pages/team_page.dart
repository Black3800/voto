import 'dart:async';
import 'dart:html';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:voto_mobile/model/items.dart';
import 'package:voto_mobile/model/persistent_state.dart';
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

  late Future<List<Items>?> _items;
  Map<String, Timer> _timers = {};

  void _forceRebuild() {
    WidgetsBinding.instance?.addPostFrameCallback((_) => setState(() {}));
  }

  Future<List<Items>?> _getItems() async {
    String? teamId = Provider.of<PersistentState>(context, listen: false).currentTeam?.id;
    if(teamId != null) {
      DatabaseReference itemsRef = FirebaseDatabase.instance.ref('teams/$teamId/items');
      List<Items> newItems = [];

      final snapshot = await itemsRef.get();
      if(snapshot.exists) {
        final data = snapshot.value as Map<dynamic,dynamic>?;
        for (String itemId in data!.keys) {
          DatabaseReference itemRef = FirebaseDatabase.instance.ref('items/$itemId');
          final itemSnapshot = await itemRef.get();
          final itemData = itemSnapshot.value as Map<dynamic,dynamic>?;
          if(itemData != null) {
            Items item = Items.fromJson(itemData);
            item.id = itemId;
            item.pollSettings!.closeDateFormatted = DateFormat.yMMMd()
                .add_Hm()
                .format(item.pollSettings!.closeDate ?? DateTime.now());
            newItems.add(item);

            if (item.pollSettings!.closeDate!.isAfter(DateTime.now())) {
              final timer = Timer(
                  item.pollSettings!.closeDate!.difference(DateTime.now()),
                  () async => await FirebaseDatabase.instance
                      .ref('items/$itemId')
                      .update(
                          {'last_modified': DateTime.now().toIso8601String()}));
              _timers[itemId] = timer;
            }
          }

          itemRef.onValue.listen((event) async {
            final itemSnapshot = event.snapshot;
            final itemData = itemSnapshot.value as Map<dynamic, dynamic>?;
            if (itemData != null) {
              Items item = Items.fromJson(itemData);
              item.id = event.snapshot.key;
              item.pollSettings!.closeDateFormatted = DateFormat.yMMMd()
                  .add_Hm()
                  .format(item.pollSettings!.closeDate ?? DateTime.now());

              _timers[item.id]?.cancel();
              
              final currentItems = await _items ?? [];
              final index = currentItems.indexWhere((element) => element.id == item.id);
              if(index >= 0) {
                currentItems[index] = Items.fromItems(item);
                _items = Future.value(List.from(currentItems));
                _forceRebuild();
              }

              if(item.pollSettings!.closeDate!.isAfter(DateTime.now())) {
                final timer = Timer(
                    item.pollSettings!.closeDate!.difference(DateTime.now()),
                    () async =>
                      await FirebaseDatabase.instance.ref('items/$itemId').update({
                        'last_modified': DateTime.now().toIso8601String()
                      })
                );
                _timers[itemId] = timer;
              }
            }
          });
        }
        newItems.sort((a, b) =>
            b.lastModified!.compareTo(a.lastModified ?? DateTime.now()));
      }
      return newItems;
    }
    return Future.value(null);
  }

  void _addListener() {
    String? teamId =
        Provider.of<PersistentState>(context, listen: false).currentTeam?.id;
    DatabaseReference itemsRef =
        FirebaseDatabase.instance.ref('teams/$teamId/items');
    itemsRef.onChildAdded.listen((event) async {
      String? itemId = event.snapshot.key;
      List<Items> _newItems = await _items ?? [];
      if (_newItems.any((e) => e.id == itemId)) return;
      if (itemId != null) {
        final data = await FirebaseDatabase.instance.ref('items/$itemId').get();
        if (data.exists) {
          final json = data.value as Map<dynamic, dynamic>?;
          if(json != null) {
            final item = Items.fromJson(json);
            item.id = itemId;
            item.pollSettings!.closeDateFormatted = DateFormat.yMMMd()
                .add_Hm()
                .format(item.pollSettings!.closeDate ?? DateTime.now());
            _newItems.add(item);
          }
        }
        _newItems.sort((a, b) =>
            b.lastModified!.compareTo(a.lastModified ?? DateTime.now()));

        _items = Future.value(_newItems);
        _forceRebuild();
      }
    });
    itemsRef.onChildRemoved.listen((event) async {
      String? itemId = event.snapshot.key;
      List<Items> _newItems = await _items ?? [];
      _newItems.removeWhere((item) => item.id == itemId);
      _newItems.sort((a, b) =>
          b.lastModified!.compareTo(a.lastModified ?? DateTime.now()));

      _items = Future.value(_newItems);
      _forceRebuild();
    });
  }

  @override
  void initState() {
    super.initState();
    _items = _getItems();
    _addListener();
  }

  @override
  void dispose() {
    for (Timer t in  _timers.values) {
      t.cancel();
    }
    super.dispose();
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
                child: FutureBuilder(
                  future: _items,
                  builder: (context, snapshot) {
                    if(snapshot.hasData) {
                      final _currentItems = snapshot.data as List<Items>?;
                      if(_currentItems!.isNotEmpty) {
                        return ListView.builder(
                          itemBuilder: (context, index) => itemCard(_currentItems[index]),
                          itemCount: _currentItems.length,
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
                    } else {
                      return const Center(
                                child: SizedBox(
                                    width: 32,
                                    height: 32,
                                    child: CircularProgressIndicator()),
                              );
                    }
                  }
                ),
              ),
            )
          ],
        ),
      )
    );
  }

  Widget itemCard(Items item) {
    final bool isClosed = item.pollSettings!.closeDate!.isBefore(DateTime.now()) || item.closed != null;
    if (isClosed) {
      return ResultCard(item: item);
    } else if (item.type == 'poll') {
      return PollCard(item: item);
    } else if (item.type == 'random') {
      return RandomCard(item: item);
    }
    return const Text('An error occurred'); // Should be impossible
  }
}
