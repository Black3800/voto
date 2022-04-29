import 'package:flutter/material.dart';
import 'package:voto_mobile/utils/color.dart';
import 'package:voto_mobile/widgets/manageteam/filed.dart';
import 'package:voto_mobile/widgets/manageteam/membercard.dart';
import 'package:voto_mobile/widgets/manageteam/outlinebutton.dart';
import 'package:voto_mobile/widgets/manageteam/ownercard.dart';
import 'package:voto_mobile/widgets/manageteam/passcode.dart';
import 'package:voto_mobile/widgets/manageteam/topic.dart';
import 'package:voto_mobile/widgets/purple_button.dart';
import 'package:voto_mobile/widgets/voto_scaffold.dart';

class ManageTeamPage extends StatelessWidget {
  const ManageTeamPage({Key? key}) : super(key: key);

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
                      Filed(title: "Integrated Project II", width: 305),
                      Topic("Join Code"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Filed(title: "au8fcd", width: 70),
                          Purple_button("Copy link to team", 132)
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
                    Membercard("Arny Anakin"),
                    Membercard("Earth Chutirat"),
                    Membercard("Aim Thanyapat"),
                    Membercard("Ninny Chutikarn")
                  ]),
                ),
              ]),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: Outline_button("Leave", 47, 305, 16),
            )
          ],
        ),
      ),
    );
  }
}
