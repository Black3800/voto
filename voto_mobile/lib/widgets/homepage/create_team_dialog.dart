import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voto_mobile/model/persistent_state.dart';
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
  String? _errorText;

  Future<void> _createTeam() async {
    final String teamImg = createTeamImage;
    final String teamName = _teamNameController.text;
    if (teamName.isEmpty) {
      setState(() => _errorText = 'Required');
      return;
    }
    String teamId;
    while (true) {
      teamId = RandomJoinCode.get();
      final data = await FirebaseDatabase.instance.ref('teams/$teamId/name').get();
      if (!data.exists) break;
    }
    DatabaseReference teamRef = FirebaseDatabase.instance.ref('teams/$teamId');
    String? uid = Provider.of<PersistentState>(context, listen: false).currentUser?.uid;
    if (uid != null) {
      /***
       * Create team
       */
      await teamRef.set({
        "img": teamImg,
        "name": _teamNameController.text,
        "owner": uid,
        "members": {uid: DateTime.now().toIso8601String()}
      });
      /***
       * Add team to user's joined_teams
       */
      DatabaseReference userRef =
          FirebaseDatabase.instance.ref("users/$uid/joined_teams");
      await userRef.update({teamId: DateTime.now().toIso8601String()});
      _teamNameController.clear();
      Navigator.of(context, rootNavigator: true).pop();
    }
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
            errorText: _errorText,
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