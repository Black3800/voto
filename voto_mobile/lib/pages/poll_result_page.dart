import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:voto_mobile/model/choice.dart';
import 'package:voto_mobile/model/persistent_state.dart';
import 'package:voto_mobile/model/users.dart';
import 'package:voto_mobile/utils/color.dart';
import 'package:voto_mobile/widgets/create_item/heading.dart';
import 'package:voto_mobile/widgets/pollresult/poll_result_button.dart';
import 'package:voto_mobile/widgets/pollresult/poll_result_item.dart';
import 'package:voto_mobile/widgets/pollresult/tiebreaker_button.dart';
import 'package:voto_mobile/widgets/pollresult/voter_dialog.dart';
import 'package:voto_mobile/widgets/voto_scaffold.dart';
import 'package:voto_mobile/widgets/winner_card.dart';

class PollResultPage extends StatefulWidget {
  const PollResultPage({Key? key}) : super(key: key);

  @override
  State<PollResultPage> createState() => _PollResultPageState();
}

class _PollResultPageState extends State<PollResultPage> {
  int totalVote = 0;
  String? itemId;
  String? uid;
  late Future<List<Choice>> _choices;

  void _forceRebuild() {
    WidgetsBinding.instance?.addPostFrameCallback((_) => setState(() {}));
  }

  Future<List<Choice>> _getChoices() async {
    if (itemId != null) {
      int _totalVote = 0;
      DatabaseReference optionsRef =
          FirebaseDatabase.instance.ref('options/$itemId/choices');
      final snapshot = await optionsRef.get();
      if (snapshot.exists) {
        final data = snapshot.value as Map<dynamic, dynamic>?;
        if (data != null) {
          List<Choice> _newChoices = [];
          for (String choiceId in data.keys) {
            Choice choice =
                Choice.fromJson(data[choiceId] as Map<dynamic, dynamic>);
            choice.id = choiceId;
            _newChoices.add(choice);
            _totalVote += choice.voteCount ?? 0;
          }
          totalVote = _totalVote;
          _forceRebuild();
          _newChoices.sort((a, b) => b.voteCount!.compareTo(a.voteCount ?? 0));
          return _newChoices;
        }
      }
    }
    return [];
  }
  
  void showVoter({ 
    required BuildContext context,
    required String text,
    required int voteCount,
    required List<Users> voters,
    String? owner
  }) {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.0))),
      context: context,
      builder: (_) {
        return VoterDialog(
          text: text,
          owner: owner != null ? 'Added by $owner' : null,
          voteCount: voteCount,
          voters: voters,
        );
      },
    );
  }

  List<Choice> _getPotentialWinners(List<Choice> list, int count) {
    List<Choice> _result = list.sublist(0, count);
    int leastVoteCount = _result.last.voteCount!;
    for (final choice in list.sublist(count)) {
      if (choice.voteCount == leastVoteCount) {
        _result.add(choice);
      }
    }
    return _result;
  }

  @override
  void initState() {
    super.initState();
    itemId = Provider.of<PersistentState>(context, listen: false).currentItem!.id;
    uid = Provider.of<PersistentState>(context, listen: false).currentUser!.uid;
    _choices = _getChoices();
  }

  Future<bool> _handlePop() async {
    Provider.of<PersistentState>(context, listen: false).disposeItem();
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PersistentState>(builder: (context, appState, child) {
      bool _showVoter = !appState.currentItem!.pollSettings!.anonymousVote;
      bool _showOwner = appState.currentItem!.pollSettings!.showOptionOwner;
      bool _isOwner = appState.currentUser!.uid == appState.currentTeam!.owner;
      return VotoScaffold(
        useMenu: false,
        title: 'Result',
        titleContext: appState.currentTeam?.name,
        onWillPop: _handlePop,
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 20.0,
                  left: 42.5,
                  right: 42.5,
                ),
                child: FutureBuilder(
                  future: _choices,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final _pollItems = snapshot.data as List<Choice>? ?? [];
                      if (_pollItems.isEmpty) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${appState.currentItem!.title}',
                                  style: GoogleFonts.inter(
                                      fontSize: 18, fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  'Closed on ${appState.currentItem!.pollSettings!.closeDateFormatted}',
                                  style: GoogleFonts.inter(
                                      fontSize: 12, fontWeight: FontWeight.w300),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Text(
                              '${appState.currentItem!.description}',
                              style: GoogleFonts.inter(
                                  fontSize: 14, fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  color: VotoColors.gray,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Empty',
                                        style: GoogleFonts.inter(
                                            fontSize: 18,
                                            color:
                                                VotoColors.black.shade300)),
                                    Text('No option was added',
                                        style: GoogleFonts.inter(
                                            color: VotoColors.black.shade300))
                                  ]),
                            )
                          ]
                        );
                      }
                      int _winnerCount = appState.currentItem!.pollSettings!.multipleWinner
                                ? appState.currentItem!.pollSettings!.winnerCount
                                : 1;
                      if (_winnerCount > _pollItems.length) {
                        _winnerCount = _pollItems.length;
                      }
                      List<Choice> _winners = _getPotentialWinners(_pollItems, _winnerCount);
                      bool _isTie = _winners.length > _winnerCount;
                      return ListView.separated(
                        itemBuilder: (context, index) => [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${appState.currentItem!.title}',
                                  style: GoogleFonts.inter(
                                      fontSize: 18, fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  'Closed on ${appState.currentItem!.pollSettings!.closeDateFormatted}',
                                  style: GoogleFonts.inter(
                                      fontSize: 12, fontWeight: FontWeight.w300),
                                ),
                              ],
                            ),
                            Text(
                              '${appState.currentItem!.description}',
                              style: GoogleFonts.inter(
                                  fontSize: 14, fontWeight: FontWeight.w400),
                            ),
                            if (_isOwner && _isTie) TiebreakerButton(winners: _winners),
                            WinnerCard(
                              winners: _winners,
                              winnerCount: _winnerCount
                            ),
                            const Heading('Full result'),
                            ..._pollItems.map((e) => PollResultItem(
                                  text: e.text ?? '',
                                  voteCount: e.voteCount ?? 0,
                                  totalVote: totalVote,
                                  showVoter: _showVoter,
                                  owner: _showOwner ? e.owner : null,
                                  voters: e.votedBy,
                                  onTap: _showVoter ? showVoter : null)),
                          ][index],
                        separatorBuilder: (context, index) => const SizedBox(height: 20),
                        itemCount: _pollItems.length + 4 + (_isOwner && _isTie ? 1 : 0),
                      );
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
            ),
            // const PollResultButton(),
          ],
        ),
      );
    });
  }
}
