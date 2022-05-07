import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:voto_mobile/utils/color.dart';
import 'package:voto_mobile/utils/random_image.dart';
import 'package:voto_mobile/utils/random_join_code.dart';
import 'package:voto_mobile/widgets/bottom_dialog.dart';
import 'package:voto_mobile/widgets/create_item/heading.dart';
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
    String teamId;
    while (true) {
      teamId = RandomJoinCode.get();
      final data = await FirebaseDatabase.instance.ref('teams/$teamId/name').once();
      if (!data.snapshot.exists) break;
    }
    FirebaseAuth.instance.authStateChanges().listen((user) async {
      DatabaseReference teamRef = FirebaseDatabase.instance.ref('teams/$teamId');
      if (user != null) {
        /***
         * Create team
         */
        final String? uid = user.uid;
        await teamRef.set({
          "img": createTeamImage,
          "name": _teamNameController.text,
          "owner": uid,
          "members": {
            uid: true
          }
        });
        /***
         * Add team to user's joined_teams
         */
        DatabaseReference userRef =
            FirebaseDatabase.instance.ref("users/$uid/joined_teams");
        await userRef.update({teamId: true});
        Navigator.of(context, rootNavigator: true).pop();
      }
    });
  }

  @override
  void dispose() {
    _teamNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BottomDialog(
      title: "Create team",
      child: ListView.separated(
        itemBuilder: (context, index) => [
          const Heading("Team name"),
          SimpleTextInput(
            controller: _teamNameController,
            icon: Icons.people,
            accentColor: VotoColors.indigo,
            max: 30,
          ),
          const Heading("Team picture"),
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