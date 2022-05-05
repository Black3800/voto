import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:voto_mobile/utils/color.dart';
import 'package:voto_mobile/utils/random_image.dart';
import 'package:voto_mobile/widgets/bottom_dialog.dart';
import 'package:voto_mobile/widgets/image_input.dart';
import 'package:voto_mobile/widgets/simple_text_input.dart';
import 'package:voto_mobile/widgets/wide_button.dart';

class CreateTeamDialog extends StatefulWidget {
  const CreateTeamDialog({ Key? key }) : super(key: key);

  @override
  State<CreateTeamDialog> createState() => _CreateTeamDialogState();
}

class _CreateTeamDialogState extends State<CreateTeamDialog> {
  final TextEditingController _teamNameController = TextEditingController();
  String createTeamImage = RandomImage.get();

  Future<void> _createTeam() async {
    DatabaseReference teamRef = FirebaseDatabase.instance.ref("teams/").push();
    FirebaseAuth.instance.authStateChanges().listen((user) async {
      if (user != null) {
        /***
         * Create team
         */
        final String? uid = user.uid;
        await teamRef.set({
          "img": createTeamImage,
          "name": _teamNameController.text,
          "owner": uid,
        });
        /***
         * Add team to user's joined_teams
         */
        if (teamRef.key != null) {
          final String teamId = teamRef.key ?? '';
          DatabaseReference userRef = FirebaseDatabase.instance.ref("users/$uid/joined_teams");
          await userRef.update({
            teamId: true
          });
          Navigator.pop(context);
        } else {
          throw Exception('teamKey.ref returns null');
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomDialog(
      title: "Create team",
      child: ListView.separated(
        itemBuilder: (context, index) => [
          Text("Team name",
              style: Theme.of(context)
                  .textTheme
                  .headline3
                  ?.merge(const TextStyle(color: VotoColors.black))),
          SimpleTextInput(
            controller: _teamNameController,
            icon: Icons.people,
            accentColor: VotoColors.indigo,
            max: 30,
          ),
          Text("Team picture",
              style: Theme.of(context)
                  .textTheme
                  .headline3
                  ?.merge(const TextStyle(color: VotoColors.black))),
          Center(
              child:
                  ImageInput(
                    image: createTeamImage,
                    radius: 150.0,
                    onChanged: (newPath) {
                        setState(() => createTeamImage = newPath);
                    },
                  )
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: WideButton(
                text: 'Create',
                onPressed: _createTeam),
          ),
        ][index],
        separatorBuilder: (context, index) => const SizedBox(height: 15.0),
        itemCount: 5,
      ),
    );
  }
}