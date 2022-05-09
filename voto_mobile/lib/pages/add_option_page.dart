import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:voto_mobile/model/persistent_state.dart';
import 'package:voto_mobile/widgets/confirm_button.dart';
import 'package:voto_mobile/widgets/create_item/heading.dart';
import 'package:voto_mobile/widgets/poll/poll_body.dart';
import 'package:voto_mobile/widgets/voto_scaffold.dart';

class AddOptionPage extends StatefulWidget {
  const AddOptionPage({Key? key}) : super(key: key);

  @override
  State<AddOptionPage> createState() => _AddOptionPageState();
}

class _AddOptionPageState extends State<AddOptionPage> {

  Future<void> _addOption(String _newOption) async {
    if (_newOption.isEmpty) return;
    String? itemId =
        Provider.of<PersistentState>(context, listen: false).currentItem?.id;
    bool showOptionOwner = Provider.of<PersistentState>(context, listen: false)
            .currentItem
            ?.pollSettings
            ?.showOptionOwner ??
        false;
    String? uid =
        Provider.of<PersistentState>(context, listen: false).currentUser?.uid;
    if (itemId != null) {
      DatabaseReference choiceRef =
          FirebaseDatabase.instance.ref('options/$itemId/choices').push();
      await choiceRef
          .set({'text': _newOption, 'owner': showOptionOwner ? uid : null});
    }
  }

  Future<void> _handleCreate() async {
    String? itemId =
        Provider.of<PersistentState>(context, listen: false).currentItem?.id;
    if (itemId != null) {
      await FirebaseDatabase.instance.ref('items/$itemId').update({
        'last_modified': DateTime.now().toIso8601String()
      });
      Provider.of<PersistentState>(context, listen: false).disposeItem();
      Navigator.of(context).popUntil(ModalRoute.withName('/team_page'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PersistentState>(builder: (context, appState, child) => 
      VotoScaffold(
        useMenu: false,
        title: 'Add option',
        titleContext: appState.currentTeam?.name,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 20.0,
                  left: 42.5,
                  right: 42.5
                ),
                child: ListView(
                  children: [
                    Text(
                        '${appState.currentItem?.title}',
                        style: GoogleFonts.inter(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    const SizedBox(height: 20.0),
                    const Heading('Options'),
                    const SizedBox(height: 20.0),
                    PollBody(
                      isSelectable: false,
                      isAddable: true,
                      onAdded: _addOption
                    )
                  ],
                ),
              ),
            ),
            ConfirmButton(
              confirmText: 'Create',
              cancelText: 'Back',
              onConfirm: _handleCreate,
              onCancel: () {
                Navigator.pop(context);
              },
              height: 75.0)
          ],
        ),
      )
    );
  }
}
