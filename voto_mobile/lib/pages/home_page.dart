import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:voto_mobile/model/persistent_state.dart';
import 'package:voto_mobile/utils/color.dart';
import 'package:voto_mobile/widgets/homepage/create_team_dialog.dart';
import 'package:voto_mobile/widgets/jointeam/join_team.dart';
import 'package:voto_mobile/widgets/rich_button.dart';
import 'package:voto_mobile/widgets/team_card.dart';
import 'package:voto_mobile/widgets/voto_scaffold.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? uid;
  late DatabaseReference teamsRef;
  List<String> teamsList = [];

  void _showCreateTeamDialog() {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.0))),
      context: context,
      builder: (_) {
        return const CreateTeamDialog();
      },
    );
  }

  void _showJoinTeamDialog() {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.0))),
      context: context,
      builder: (_) {
        return JoinTeam(
          teams: teamsList
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    uid = Provider.of<PersistentState>(context, listen: false).currentUser!.uid;
    teamsRef = FirebaseDatabase.instance.ref('users/$uid/joined_teams');
  }

  @override
  Widget build(BuildContext context) {
    return VotoScaffold(
      useMenu: true,
      title: 'My Team',
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichButton(
                    text: 'Create team',
                    icon: Icons.add,
                    accentColor: VotoColors.indigo,
                    onPressed: _showCreateTeamDialog),
                const SizedBox(
                  width: 10.0,
                ),
                RichButton(
                    text: 'Join team',
                    icon: Icons.people,
                    accentColor: VotoColors.magenta,
                    onPressed: _showJoinTeamDialog)
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: teamsRef.onValue,
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
                  final _teams = snapshot.data?.snapshot.value as Map<dynamic, dynamic>?;
                  if(_teams != null) {
                    final _teamsList = _teams
                          .map((key, value) =>
                              MapEntry(key, DateTime.parse(value)))
                          .entries
                          .toList();
                    _teamsList.sort((a, b) => a.value.compareTo(b.value));
                    teamsList = List.from(_teamsList.map((e) => e.key));
                    return ListView.builder(
                        itemBuilder: (context, index) =>
                            TeamCard(id: teamsList[index]),
                        itemCount: teamsList.length);
                  } else {
                    return Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.group_add,
                                color: VotoColors.black.shade400,
                                size: 64,
                              ),
                              const SizedBox(height: 24),
                              Text('Create or join a team to get started',
                                  style: GoogleFonts.inter(
                                      fontSize: 18, color: VotoColors.black)),
                            ]),
                      );
                  }
                }
                return Container();
              }
            ),
          )
        ],
      ),
    );
  }
}
