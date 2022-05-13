import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

class ManageTeamPage extends StatefulWidget {
  const ManageTeamPage({Key? key}) : super(key: key);

  @override
  State<ManageTeamPage> createState() => _ManageTeamPageState();
}

class _ManageTeamPageState extends State<ManageTeamPage> {

  String _copyText = 'Copy to clipboard';
  IconData _copyIcon = Icons.copy;
  Timer? _copyTimer;

  void _handleCopy() {
    _copyTimer?.cancel;
    setState(() {
      _copyText = 'Copied';
      _copyIcon = Icons.check;
    });
    _copyTimer = Timer(const Duration(seconds: 3), () {
      _revertCopyState();
    });
  }

  void _revertCopyState() {
    setState(() {
      _copyText = 'Copy to clipboard';
      _copyIcon = Icons.copy;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _copyTimer?.cancel();
    super.dispose();
  }

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
                        Container(
                          width: 80,
                          height: 35,
                          decoration: BoxDecoration(
                            color: VotoColors.gray,
                            borderRadius: BorderRadius.circular(12)
                          ),
                          child: Center(child: Text('${appState.currentTeam?.id}'))
                        ),
                        Purple_button(
                          text: _copyText,
                          icon: _copyIcon,
                          onPressed: () {
                            Clipboard.setData(ClipboardData(text: appState.currentTeam?.id));
                            _handleCopy();
                          }
                        )
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
                                image: 'gs://cs21-voto.appspot.com/dummy/blank.webp',
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
