import 'package:flutter/material.dart';
import 'package:voto_mobile/utils/color.dart';
import 'package:voto_mobile/widgets/manageteam/filed.dart';
import 'package:voto_mobile/widgets/manageteam/membercard.dart';
import 'package:voto_mobile/widgets/manageteam/outlinebutton.dart';
import 'package:voto_mobile/widgets/manageteam/passcode.dart';
import 'package:voto_mobile/widgets/manageteam/topic.dart';
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
            Topic("Team name"),
            const SizedBox(height: 15.0),
            Row(
              children: const [
                Filed(text: "Integrated Project II", readOnly: false),
              ],
            ),
            const SizedBox(height: 15.0),
            Topic("Join Code"),
            const SizedBox(height: 15.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 70.0, child: Filed(text: "au8fcd")),
                Purple_button()
              ],
            ),
            const SizedBox(height: 15.0),
            Topic("Passcode"),
            const SizedBox(height: 15.0),
            const Pass(),
            const SizedBox(height: 15.0),
            Topic("Member"),
            const SizedBox(height: 15.0),
            Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index) => [
                        const Membercard(name: "Tanny Paninun", isOwner: true),
                        const Membercard(name: "Arny Anakin", kickable: true),
                        const Membercard(
                            name: "Earth Chutirat", kickable: true),
                        const Membercard(name: "Aim Thanypat", kickable: true),
                        const Membercard(
                            name: "Ninny Chutikarn", kickable: true),
                      ][index],
                  separatorBuilder: (context, index) => const Divider(
                        height: 15.0,
                        color: VotoColors.gray,
                        thickness: 1.0,
                      ),
                  itemCount: 5),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 24.0),
              child: Outline_button(text: "Delete team", padding: 16.0),
            )
          ],
        ),
      ),
    );
  }
}
