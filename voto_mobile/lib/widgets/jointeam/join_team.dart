import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:voto_mobile/model/persistent_state.dart';
import 'package:voto_mobile/model/team.dart';
import 'package:voto_mobile/utils/color.dart';
import 'package:voto_mobile/widgets/bottom_dialog.dart';
import 'package:voto_mobile/widgets/jointeam/enter_passcode_dialog.dart';
import 'package:voto_mobile/widgets/simple_text_input.dart';
import 'package:voto_mobile/widgets/voto_snackbar.dart';
import 'package:voto_mobile/widgets/wide_button.dart';

class JoinTeam extends StatefulWidget {
  final List<String> teams;
  const JoinTeam({
    Key? key,
    this.teams = const []
  }) : super(key: key);

  @override
  State<JoinTeam> createState() => _JoinTeamState();
}

class _JoinTeamState extends State<JoinTeam> {

  final TextEditingController _joinCodeController = TextEditingController();
  String? _error;

  void _showEnterPasscodeDialog({required Team team, required Function onSuccess}) {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return EnterPasscodeDialog(
          team: team,
          onSuccess: onSuccess,
        );
      },
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.0))),
    );
  }

  Future<void> _pushTeamUpdate(Team team) async {
    String? uid = Provider.of<PersistentState>(context, listen: false).currentUser?.uid;
    if (uid != null) {
      DatabaseReference userRef =
          FirebaseDatabase.instance.ref("users/$uid/joined_teams");
      await userRef.update({'${team.id}': DateTime.now().toIso8601String()});

      DatabaseReference teamRef =
          FirebaseDatabase.instance.ref("teams/${team.id}/members");
      await teamRef.update({uid: DateTime.now().toIso8601String()});
    }
  }

  Future<void> _joinTeam() async {
    final String teamId = _joinCodeController.text;
    final String? latestTeamLeft = Provider.of<PersistentState>(context, listen: false).latestTeamLeft;
    /***
     * Check if team is already joined
     */
    if(teamId != latestTeamLeft && widget.teams.any((_team) => _team == teamId)) {
      Navigator.pop(context);
      VotoSnackbar(
        text: 'You are already in that team',
        accentColor: VotoColors.cyan,
        icon: Icons.info_outline
      ).show(context);
      return;
    }

    DatabaseReference ref = FirebaseDatabase.instance.ref('teams/$teamId');
    final snapshot = await ref.get();
    if (snapshot.exists) {
      final team = Team.fromJson(snapshot.value as Map<dynamic, dynamic>);
      team.id = teamId;
      if(team.passcode != null) {
        Navigator.pop(context);
        _showEnterPasscodeDialog(
          team: team,
          onSuccess: () {
            _pushTeamUpdate(team);
          }
        );
      } else {
        _pushTeamUpdate(team).then((_) {
          Navigator.pop(context);
        });
      }
    } else {
      setState(() => _error = 'Team does not exist');
    }
  }

  @override
  void dispose() {
    _joinCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BottomDialog(
      title: 'Join team',
      child: ListView(
        children: [
          Text("Enter team's join code or the link you received",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.merge(GoogleFonts.inter(color: VotoColors.black))),
          const SizedBox(height: 15.0),
          Text("Join code",
              style: Theme.of(context)
                  .textTheme
                  .headline3
                  ?.merge(GoogleFonts.inter(color: VotoColors.black))),
          const SizedBox(height: 15.0),
          SimpleTextInput(
            controller: _joinCodeController,
            accentColor: VotoColors.indigo,
            errorText: _error,
            max: 6,
          ),
          const SizedBox(height: 30.0),
          WideButton(text: 'Join', onPressed: _joinTeam)
        ],
      ),
    );
  }
}
