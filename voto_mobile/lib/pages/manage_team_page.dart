import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:voto_mobile/model/persistent_state.dart';
import 'package:voto_mobile/model/team.dart';
import 'package:voto_mobile/utils/color.dart';
import 'package:voto_mobile/widgets/manageteam/filed.dart';
import 'package:voto_mobile/widgets/manageteam/membercard.dart';
import 'package:voto_mobile/widgets/manageteam/outlinebutton.dart';
import 'package:voto_mobile/widgets/manageteam/passcode.dart';
import 'package:voto_mobile/widgets/manageteam/topic.dart';
import 'package:voto_mobile/widgets/purple_button.dart';
import 'package:voto_mobile/widgets/voto_scaffold.dart';

class ManageTeamPage extends StatefulWidget {
  const ManageTeamPage({Key? key}) : super(key: key);

  @override
  State<ManageTeamPage> createState() => _ManageTeamPageState();
}

class _ManageTeamPageState extends State<ManageTeamPage> {

  late final TextEditingController _teamNameController;
  String? uid;
  String? teamId;
  String? ownerId;
  late DatabaseReference _membersRef;

  Future<void> _handleChangePasscode(String newPasscode) async {
    Team _team = Provider.of<PersistentState>(context, listen: false).currentTeam!;
    if (newPasscode.isNotEmpty) {
      await FirebaseDatabase.instance.ref('teams/$teamId').update({
        'passcode': newPasscode
      });
      _team.passcode = newPasscode;
    } else {
      await FirebaseDatabase.instance.ref('teams/$teamId/passcode').remove();
      _team.passcode = null;
    }
    Provider.of<PersistentState>(context, listen: false).updateTeam(_team);
  }

  Future<void> _handleChangeName(String? newName) async {
    Team _team = Provider.of<PersistentState>(context, listen: false).currentTeam!;
    if (newName != null && newName.isNotEmpty && newName != _team.name) {
      await FirebaseDatabase.instance.ref('teams/$teamId').update({
        'name': newName
      });
      _team.name = newName;
      Provider.of<PersistentState>(context, listen: false).updateTeam(_team);
      /***
       * Add 1ms to join date to force rebuild in homepage
       */
      final joinData = await FirebaseDatabase.instance
          .ref('users/$uid/joined_teams/$teamId')
          .get();
      final joinSince = DateTime.parse(joinData.value as String);
      await FirebaseDatabase.instance.ref('users/$uid/joined_teams').update({
        teamId!:
            joinSince.add(const Duration(milliseconds: 1)).toIso8601String()
      });
    } else {
      _teamNameController.text = _team.name;
    }
    FocusScope.of(context).unfocus();
  }

  Future<bool> _confirmAction({
    required String title,
    required String detail,
    required String actionText
  }) async {
    final isConfirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          title,
          style: Theme.of(context).textTheme.headline2!.merge(GoogleFonts.inter(
            color: VotoColors.danger
          )),
        ),
        content: Text(detail,
            style: Theme.of(context).textTheme.bodyText1),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Cancel',
                style: GoogleFonts.inter(fontWeight: FontWeight.normal)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(actionText,
                style: GoogleFonts.inter(color: VotoColors.danger)),
            style: ButtonStyle(
                overlayColor:
                    MaterialStateProperty.all(VotoColors.danger.shade300),
                backgroundColor: MaterialStateProperty.resolveWith((states) {
                  if (states.contains(MaterialState.pressed)) {
                    return VotoColors.danger.shade300;
                  }
                  return VotoColors.danger.shade100;
                }),
                fixedSize:
                    MaterialStateProperty.all<Size>(const Size.fromWidth(100))),
          ),
        ],
      ),
    );
    return Future.value(isConfirmed);
  }

  Future<void> _handleDelete() async {
    _confirmAction(
      title: 'Delete team?',
      detail: 'Everything in this team will be deleted FOREVER and could not be undo',
      actionText: 'Delete'
    ).then((willDelete) async {
      if (!willDelete) return;
      final teamSnapshot =
          await FirebaseDatabase.instance.ref('teams/$teamId').get();
      final teamData = teamSnapshot.value as Map;
      final team = Team.fromJson(teamData);
      final members = team.members;
      final items = team.items;
      if (items != null) {
        final itemUpdate =
            items.map((key, value) => MapEntry(key as String, null));
        await FirebaseDatabase.instance.ref('options').update(itemUpdate);
        await FirebaseDatabase.instance.ref('items').update(itemUpdate);
      }
      for (final memberId in members.keys) {
        await FirebaseDatabase.instance
            .ref('users/$memberId/joined_teams/$teamId')
            .remove();
      }
      await FirebaseDatabase.instance.ref('teams/$teamId').remove();
      Provider.of<PersistentState>(context, listen: false).disposeItem();
      Provider.of<PersistentState>(context, listen: false).disposeTeam();
      Navigator.of(context).popUntil(ModalRoute.withName('/home_page'));
    });
  }

  Future<void> _handleLeave() async {
    _confirmAction(
      title: 'Leave team?',
      detail: 'You could join this team again via the same code',
      actionText: 'Leave'
    ).then((willLeave) async {
      if (!willLeave) return;
      await FirebaseDatabase.instance.ref('users/$uid/joined_teams/$teamId').remove();
      await FirebaseDatabase.instance.ref('teams/$teamId/members/$uid').remove();
      Provider.of<PersistentState>(context, listen: false).disposeItem();
      Provider.of<PersistentState>(context, listen: false).disposeTeam();

      /***
       * To make this team joinable if this is the last team of this user
       */
      Provider.of<PersistentState>(context, listen: false).latestTeamLeft = teamId;

      Navigator.of(context).popUntil(ModalRoute.withName('/home_page'));
    });
  }

  Future<void> _handleKick(String memberId) async {
    _confirmAction(
      title: 'Kick member?',
      detail: 'This member could still join again if you do not change passcode',
      actionText: 'Kick'
    ).then((willKick) async {
      if (!willKick) return;
      await FirebaseDatabase.instance.ref('users/$memberId/joined_teams/$teamId').remove();
      await FirebaseDatabase.instance.ref('teams/$teamId/members/$memberId').remove();
    });
  }

  @override
  void initState() {
    super.initState();
    uid = Provider.of<PersistentState>(context, listen: false).currentUser!.uid;
    teamId = Provider.of<PersistentState>(context, listen: false).currentTeam!.id;
    ownerId = Provider.of<PersistentState>(context, listen: false).currentTeam!.owner;
    _membersRef = FirebaseDatabase.instance.ref('teams/$teamId/members');
    _teamNameController = TextEditingController(
        text: Provider.of<PersistentState>(context, listen: false)
            .currentTeam!
            .name);
  }

  @override
  void dispose() {
    _teamNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PersistentState>(
        builder: (context, appState, child) => VotoScaffold(
              title: "Manage team",
              titleContext: appState.currentTeam?.name,
              useMenu: false,
              onWillPop: () {
                if (appState.currentUser!.uid == appState.currentTeam?.owner) {
                  _handleChangeName(_teamNameController.text);
                }
                return Future.value(true);
              },
              body: Padding(
                padding:
                    const EdgeInsets.only(left: 42.5, right: 42.5, top: 20),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Topic("Team name"),
                            const SizedBox(height: 15.0),
                            Row(
                              children: [
                                Filed(
                                  controller: _teamNameController,
                                  readOnly: !(appState.currentUser!.uid == appState.currentTeam?.owner),
                                  onChanged: _handleChangeName
                                ),
                              ],
                            ),
                            const SizedBox(height: 15.0),
                            Topic("Join Code"),
                            const SizedBox(height: 15.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 80,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    color: VotoColors.gray,
                                    borderRadius: BorderRadius.circular(12)
                                  ),
                                  child: Center(child: Text('${appState.currentTeam?.id}'))
                                ),
                                const Purple_button()
                              ],
                            ),
                            const SizedBox(height: 15.0),
                            Topic("Passcode"),
                            const SizedBox(height: 15.0),
                            Pass(
                              isEditing: !(appState.currentUser!.uid == appState.currentTeam?.owner),
                              value: appState.currentTeam?.passcode ?? '    ',
                              onChanged: _handleChangePasscode,
                            ),
                            const SizedBox(height: 15.0),
                            Topic("Member"),
                            const SizedBox(height: 15.0),
                            StreamBuilder(
                              stream: _membersRef.onValue,
                              builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return const Center(
                                      child: SizedBox(
                                          width: 32,
                                          height: 32,
                                          child: CircularProgressIndicator()),
                                    );
                                } else if (snapshot.connectionState == ConnectionState.active && snapshot.hasData) {
                                  final data = snapshot.data?.snapshot.value as Map?;
                                  if (data == null) return Container();
                                  final members = data.keys.toList();
                                  members.insert(0, members.removeAt(members.indexOf(ownerId)));
                                  return Column(
                                    children: members
                                            .map((m) => [
                                                  Membercard(
                                                      id: m,
                                                      isOwner: m == ownerId,
                                                      kickable: m != ownerId &&
                                                          (appState.currentUser!
                                                                  .uid ==
                                                              appState
                                                                  .currentTeam
                                                                  ?.owner),
                                                      onKick: () =>
                                                          _handleKick(m)),
                                                  const Divider(
                                                    height: 15.0,
                                                    color: VotoColors.gray,
                                                    thickness: 1.0,
                                                  )
                                                ])
                                            .expand((i) => i)
                                            .toList()
                                  );
                                }
                                return Container();
                              }
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Outline_button(
                          text: (appState.currentUser!.uid ==
                                  appState.currentTeam?.owner)
                              ? "Delete team"
                              : "Leave",
                          padding: 16.0,
                          onPressed: () {
                            if (appState.currentUser!.uid == appState.currentTeam?.owner) {
                              _handleDelete();
                            } else {
                              _handleLeave();
                            }
                          }),
                    )
                  ],
                ),
              ),
            ));
  }
}
