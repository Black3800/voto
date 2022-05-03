import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:voto_mobile/model/team.dart';
import 'package:voto_mobile/model/users.dart';
import 'package:voto_mobile/utils/color.dart';
import 'package:voto_mobile/widgets/bottom_dialog.dart';
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
      context: context,
      builder: (BuildContext context) {
        return BottomDialog(
            title: "Create team",
            child: ListView(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Team name",
                      style: Theme.of(context)
                          .textTheme
                          .headline3
                          ?.merge(const TextStyle(color: VotoColors.black))),
                  const SizedBox(height: 15.0),
                  const SimpleTextInput(
                      icon: Icons.people, accentColor: VotoColors.indigo),
                  const SizedBox(height: 15.0),
                  Text("Team picture",
                      style: Theme.of(context)
                          .textTheme
                          .headline3
                          ?.merge(const TextStyle(color: VotoColors.black))),
                  const SizedBox(height: 15.0),
                  const Center(
                      child: ImageInput(
                    initial: 'T',
                    radius: 150.0,
                  )),
                  const SizedBox(height: 30.0),
                  WideButton(
                      text: 'Create',
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                ],
              ),
            );
      },
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.0))),
    );
  }

  showJoinTeamDialog() {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.0))),
      context: context,
      builder: (_) {
        return const JoinTeam();
      },
    );
  }

  /// Start app -> Home page -> initState() -> Fetch DB -> Put into list
  
  Future<void> _getAllTeams() async {
    // Firebase is asynchronous
    FirebaseAuth.instance.authStateChanges().listen((event) {
      String uid = FirebaseAuth.instance.currentUser?.uid ?? '';
      DatabaseReference ref = FirebaseDatabase.instance.ref('users/' + uid);
      ref.onValue.listen((DatabaseEvent event) async {
        final json = event.snapshot.value as Map<dynamic, dynamic>;
        final data = Users.fromJson(json);
        final teams = data.joined_teams.keys;
        for(String team_id in teams) {
          DatabaseReference ref = FirebaseDatabase.instance.ref('teams/' + team_id);
          final snapshot = await ref.get();
          if(snapshot.exists) {
            final team = Team.fromJson(snapshot.value as Map<dynamic, dynamic>);
            teamsList.add(team);
          }
        }
        setState(() {
          teamsList = List.from(teamsList);
        });
      });
    });
  }

  @override
  void initState() {
    _getAllTeams();
    super.initState();
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
              itemBuilder: (context, index) => TeamCard(
                imagePath: teamsList[index].img,
                title: teamsList[index].name,
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/team_page',
                    arguments: teamsList[index]
                  );
                }
              ),
              itemCount: teamsList.length
            ),
          )
        ],
      ),
    );
  }
}
