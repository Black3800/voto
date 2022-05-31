import 'dart:typed_data';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:voto_mobile/model/choice.dart';
import 'package:voto_mobile/model/persistent_state.dart';
import 'package:voto_mobile/utils/color.dart';
import 'package:voto_mobile/utils/image_share.dart';
import 'package:voto_mobile/widgets/random/random_body.dart';
import 'package:voto_mobile/widgets/random/start_button.dart';
import 'package:voto_mobile/widgets/share_button.dart';
import 'package:voto_mobile/widgets/voto_scaffold.dart';

class RandomPage extends StatefulWidget {
  const RandomPage({Key? key}) : super(key: key);

  @override
  State<RandomPage> createState() => _RandomPageState();
}

class _RandomPageState extends State<RandomPage> {

  String? itemId;
  String? teamId;
  bool isSharing = false;
  bool isSaving = false;
  late FToast fToast;
  late DatabaseReference _optionsRef;
  late List<Choice> _choices;
  late bool _isClosed;
  final ScreenshotController screenshotController = ScreenshotController();

  Future<void> _stopRandom(String itemId, String type) async {
    final snapshot = await _optionsRef.child('choices').get();
    if (snapshot.exists) {
      final data = snapshot.value as Map;
      final choices = data.keys.toList();
      if (type == 'lucky') {
        if (choices.length < 2) {
          _showWarningToast('Need at least 2 options');
          return;
        }
        choices.shuffle();
        await _optionsRef.child('choices/${choices.first}').update({'win': true});
        await _optionsRef.child('winner').update({choices.first: true});
      } else {
        final memberSnapshot = await FirebaseDatabase.instance.ref('teams/$teamId/members').get();
        if (memberSnapshot.exists) {
          final memberData = memberSnapshot.value as Map;
          final members = memberData.keys.toList();
          final Map<String,String> result = {};
          int i = 0;
          while (i < choices.length) {
            if (i % members.length == 0) {
              members.shuffle();
            }
            result[choices[i]] = members[i % members.length];
            await _optionsRef.child('choices/${choices[i]}').update({'assignee': members[i % members.length]});
            i++;
          }
          await _optionsRef.child('winner').update(result);
        }
      }
      await FirebaseDatabase.instance.ref('items/$itemId').update({
          'closed': true,
          'last_modified': DateTime.now().toIso8601String()
        });
    }
  }

  Future<Widget> _buildResultWidget() async {
    final _item = Provider.of<PersistentState>(context, listen: false).currentItem!;
    return Material(
            color: VotoColors.white,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '${_item.title}',
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: VotoColors.black
                    ),
                  ),
                  RandomBody(
                    type: _item.randomType!,
                    choices: _choices,
                    renderAsResult: true,
                    context: context
                  ),
                ]
              ),
            ),
          );
  }

  void _showSuccessToast(String text) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: VotoColors.black.shade600,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.check, color: VotoColors.success),
          const SizedBox(width: 6.0),
          Flexible(
              child: Text(
            text,
            style: GoogleFonts.inter(color: VotoColors.white),
            textAlign: TextAlign.center,
          )),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: const Duration(seconds: 2),
    );
  }

  void _showWarningToast(String text) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: VotoColors.black.shade600,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.warning_rounded, color: VotoColors.warning),
          const SizedBox(width: 6.0),
          Flexible(
              child: Text(
            text,
            style: GoogleFonts.inter(color: VotoColors.white),
            textAlign: TextAlign.center,
          )),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: const Duration(seconds: 2),
    );
  }

  Future<bool> _handlePop() async {
    Provider.of<PersistentState>(context, listen: false).disposeItem();
    return Future.value(true);
  }

  @override
  void initState() {
    super.initState();
    itemId = Provider.of<PersistentState>(context, listen: false).currentItem!.id;
    teamId = Provider.of<PersistentState>(context, listen: false).currentTeam!.id;
    _optionsRef = FirebaseDatabase.instance.ref('options/$itemId');
    fToast = FToast();
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    final _shareButton = ShareButton(
        shareText: 'Share',
        saveText: 'Save as image',
        useToggle: true,
        onShare: () async {
          final result = await _buildResultWidget();
          screenshotController.captureFromWidget(
            result,
            delay: Duration(milliseconds: 1000 + _choices.length * 10),
            context: context
          ).then((Uint8List? image) async {
            if (image == null) return;
            await ImageShare.shareImage(image);
            Navigator.of(context).pop();
          });
        },
        onSave: () async {
          final result = await _buildResultWidget();
          screenshotController.captureFromWidget(
            result,
            delay: Duration(milliseconds: 3000 + _choices.length * 100),
            context: context
          ).then((Uint8List? image) async {
            if (image == null) return;
            await ImageShare.saveImage(image);
            _showSuccessToast('Result saved to gallery');
            Navigator.of(context).pop();
          });
        });

    return Consumer<PersistentState>(builder: (context, appState, child) {
      _isClosed = appState.currentItem!.closed ?? false;
      final _item = appState.currentItem!;

      Widget grayBanner(title, subtitle) => Expanded(
        child: Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 42.5, right: 42.5),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                '${_item.title}',
                style:
                    GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15.0),
              Text(
                '${_item.description}',
                style: GoogleFonts.inter(
                    fontSize: 14, fontWeight: FontWeight.normal),
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 15.0),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: VotoColors.gray,
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('$title',
                          style: GoogleFonts.inter(
                              fontSize: 18, color: VotoColors.black.shade300)),
                      Text('$subtitle',
                          style:
                              GoogleFonts.inter(color: VotoColors.black.shade300))
                    ]),
              )
            ])),
      );

      return VotoScaffold(
        title: "Random",
        titleContext: appState.currentTeam?.name,
        useMenu: false,
        onWillPop: _handlePop,
        body: Column(
          children: [
            StreamBuilder(
              stream: _optionsRef.onValue,
              builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: SizedBox(
                        width: 32, height: 32, child: CircularProgressIndicator()),
                  );
                } else if (snapshot.connectionState == ConnectionState.active && snapshot.hasData) {
                  final data = snapshot.data!.snapshot.value as Map?;
                  if (data == null) {
                    return grayBanner('Empty', 'Add some options');
                  }
                  List<Choice> choices = [];
                  for (final choice in data['choices'].entries) {
                    final _choice = Choice.fromJson(choice.value);
                    _choice.id = choice.key;
                    choices.add(_choice);
                  }
                  _choices = choices;
                  if (_item.randomType == 'lucky' && _choices.length < 2) {
                    return grayBanner('Waiting', 'Add at least 2 options');
                  } else if (_item.randomType == 'pair' && appState.currentTeam!.members.length < 2) {
                    return grayBanner('Waiting', 'Need at least 2 members in team');
                  }
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 20.0,
                        left: 42.5,
                        right: 42.5
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${appState.currentItem!.title}',
                            style: GoogleFonts.inter(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 15.0),
                          Text(
                            '${appState.currentItem!.description}',
                            style: GoogleFonts.inter(
                                fontSize: 14, fontWeight: FontWeight.normal),
                            textAlign: TextAlign.start,
                          ),
                          const SizedBox(height: 15.0),
                          RandomBody(
                            type: appState.currentItem!.randomType!,
                            choices: choices,
                            isClosed: _isClosed
                          ),
                        ]
                      ),
                    ),
                  );
                }
                return Container();
              }
            ),
            if (!_isClosed)
              if (appState.currentUser!.uid == appState.currentTeam!.owner)
                StartButton(
                  onPressed: () => _stopRandom(appState.currentItem!.id!,
                      appState.currentItem!.randomType!),
                  disabled: _item.randomType == 'pair' && appState.currentTeam!.members.length < 2,
                )
              else
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 32.5, horizontal: 42.5),
                  child: Row(
                    children: [
                      const Icon(Icons.info, color: Color(0xffaaaaaa)),
                      const SizedBox(width: 10.0),
                      Expanded(
                        child: Text(
                            'Wait for the team owner to stop the random',
                            textAlign: TextAlign.left,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.apply(color: const Color(0xffaaaaaa))),
                      )
                    ],
                  ),
                )
            else
              _shareButton
          ],
        ),
      );
    });
  }
}
