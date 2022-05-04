import 'package:flutter/material.dart';
import 'package:voto_mobile/utils/color.dart';
import 'package:voto_mobile/widgets/manageteam/filed.dart';
import 'package:voto_mobile/widgets/manageteamowner/member.dart';
import 'package:voto_mobile/widgets/manageteam/outlinebutton.dart';
import 'package:voto_mobile/widgets/manageteam/ownercard.dart';
import 'package:voto_mobile/widgets/manageteam/passcode.dart';
import 'package:voto_mobile/widgets/manageteam/topic.dart';
import 'package:voto_mobile/widgets/manageteamowner/delete_team_button.dart';
import 'package:voto_mobile/widgets/manageteamowner/edit_team_name.dart';
import 'package:voto_mobile/widgets/purple_button.dart';
import 'package:voto_mobile/widgets/voto_scaffold.dart';

class ManageTeamOwnerPage extends StatelessWidget {
  const ManageTeamOwnerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VotoScaffold(
      title: "Manage team",
      titleContext: "Integrated Project II",
      useMenu: false,
      body: Padding(
        padding: const EdgeInsets.only(left: 42.5, right: 42.5, top: 20),
        child: Column(
          children: [
            Expanded(
              child: ListView(children: [
                Container(
                  child: Column(
                    children: [
                      Topic("Team name"),
                      const EditTeamName(
                        name: '',
                      ),
                      Topic("Join Code"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Filed(title: "au8fcd", width: 70),
                          Purple_button()
                        ],
                      ),
                      Topic("Passcode"),
                      Pass(),
                    ],
                  ),
                ),
                Container(
                  child: Column(children: [
                    Topic("Member"),
                    Ownercard("Tanny Paninun"),
                    Member("Arny Anakin"),
                    Member("Earth Chutirat"),
                    Member("Aim Thanyapat"),
                    Member("Ninny Chutikarn"),
                    
                  ],),
                ),
                
              ],),
            ),
            DeleteTeamButton(),
          ],
        ),
      ),
    );
  }
}
