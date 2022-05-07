import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voto_mobile/model/persistent_state.dart';
import 'package:voto_mobile/utils/color.dart';
import 'package:voto_mobile/widgets/manageteam/filed.dart';
import 'package:voto_mobile/widgets/manageteam/membercard.dart';
import 'package:voto_mobile/widgets/manageteam/outlinebutton.dart';
import 'package:voto_mobile/widgets/manageteam/passcode.dart';
import 'package:voto_mobile/widgets/manageteam/topic.dart';
import 'package:voto_mobile/widgets/purple_button.dart';
import 'package:voto_mobile/widgets/voto_scaffold.dart';

class ManageTeamPage extends StatelessWidget {
  const ManageTeamPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String ownerName = 'Tanny Panitnun';
    bool iAmOwner = true;
    List<String> membersName = [
      'Tanny Panitnun',
      'Arny Anakin',
      'Earth Chutirat',
      'Aim Thanypat',
      'Ninny Chutikarn'
    ];
    String joinCode = 'au8fcd';

    return Consumer<PersistentState>(
        builder: (context, appState, child) => VotoScaffold(
              title: "Manage team",
              titleContext: appState.currentTeam?.name,
              useMenu: false,
              body: Padding(
                padding:
                    const EdgeInsets.only(left: 42.5, right: 42.5, top: 20),
                child: Column(
                  children: [
                    Topic("Team name"),
                    const SizedBox(height: 15.0),
                    Row(
                      children: [
                        Filed(
                          text: appState.currentTeam?.name,
                          readOnly: !iAmOwner,
                        ),
                      ],
                    ),
                    const SizedBox(height: 15.0),
                    Topic("Join Code"),
                    const SizedBox(height: 15.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(width: 70.0, child: Filed(text: joinCode)),
                        Purple_button()
                      ],
                    ),
                    const SizedBox(height: 15.0),
                    Topic("Passcode"),
                    const SizedBox(height: 15.0),
                    Pass(
                      isEditing: !iAmOwner,
                    ),
                    const SizedBox(height: 15.0),
                    Topic("Member"),
                    const SizedBox(height: 15.0),
                    Expanded(
                      child: ListView.separated(
                          itemBuilder: (context, index) => Membercard(
                                name: membersName[index],
                                isOwner: membersName[index] == ownerName,
                                kickable:
                                    ownerName != membersName[index] && iAmOwner,
                              ),
                          separatorBuilder: (context, index) => const Divider(
                                height: 15.0,
                                color: VotoColors.gray,
                                thickness: 1.0,
                              ),
                          itemCount: 5),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24.0),
                      child: Outline_button(
                          text: iAmOwner ? "Delete team" : "Leave",
                          padding: 16.0),
                    )
                  ],
                ),
              ),
            ));
  }
}
