import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voto_mobile/model/persistent_state.dart';
import 'package:voto_mobile/model/team.dart';
import 'package:voto_mobile/model/users.dart';
import 'package:voto_mobile/utils/color.dart';
import 'package:voto_mobile/utils/random_image.dart';
import 'package:voto_mobile/widgets/bottom_dialog.dart';
import 'package:voto_mobile/widgets/homepage/create_team_dialog.dart';
import 'package:voto_mobile/widgets/image_input.dart';
import 'package:voto_mobile/widgets/jointeam/join_team.dart';
import 'package:voto_mobile/widgets/rich_button.dart';
import 'package:voto_mobile/widgets/simple_text_input.dart';
import 'package:voto_mobile/widgets/team_card.dart';
import 'package:voto_mobile/widgets/voto_scaffold.dart';
import 'package:voto_mobile/widgets/wide_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Team> teamsList = [];

  void showCreateTeamDialog() {
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

  showJoinTeamDialog() {
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

  Future<void> _getAllTeams() async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        /***
         * Fetch user's joined teams
         */
        String uid = user.uid;
        DatabaseReference ref = FirebaseDatabase.instance.ref('users/' + uid);
        ref.onValue.listen((DatabaseEvent event) async {
          if (event.snapshot.exists && event.snapshot.value != null) {
            final json = event.snapshot.value as Map<dynamic, dynamic>;
            final data = Users.fromJson(json);
            final teams = data.joinedTeams?.keys;
            List<Team> newTeamsList = [];
            /***
             * For each team, fetch the name and image
             */
            if (teams != null) {
              for (String teamId in teams) {
                DatabaseReference ref =
                    FirebaseDatabase.instance.ref('teams/' + teamId);
                final snapshot = await ref.get();
                if (snapshot.exists) {
                  final team =
                      Team.fromJson(snapshot.value as Map<dynamic, dynamic>);
                  
                  team.id = teamId;

                  /***
                   * Add team to the list for the ListView.builder to buid
                   */
                  newTeamsList.add(team);
                }
              }
            }
            if (mounted) {
              setState(() => teamsList = List.from(newTeamsList));
            }
          }
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _getAllTeams();
  }

  @override
  void dispose() {
    teamsList = [];
    super.dispose();
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
                    onPressed: showCreateTeamDialog),
                const SizedBox(
                  width: 10.0,
                ),
                RichButton(
                    text: 'Join team',
                    icon: Icons.people,
                    accentColor: VotoColors.magenta,
                    onPressed: showJoinTeamDialog)
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemBuilder: (context, index) {
                  return TeamCard(
                    imagePath: teamsList[index].img,
                    title: teamsList[index].name,
                    onTap: () {
                      Provider.of<PersistentState>(context, listen: false)
                        .updateTeam(teamsList[index]);
                      Navigator.pushNamed(
                        context,
                        '/team_page',
                        arguments: teamsList[index]);
                    });
                },
                itemCount: teamsList.length),
          )
        ],
      ),
    );
  }
}
