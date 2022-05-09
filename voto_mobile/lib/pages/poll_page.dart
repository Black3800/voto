import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:voto_mobile/model/items.dart';
import 'package:voto_mobile/model/persistent_state.dart';
import 'package:voto_mobile/widgets/confirm_button.dart';
import 'package:voto_mobile/widgets/poll/poll_body.dart';
import 'package:voto_mobile/widgets/voto_scaffold.dart';

class PollPage extends StatefulWidget {
  const PollPage({Key? key}) : super(key: key);

  @override
  State<PollPage> createState() => _PollPageState();
}

class _PollPageState extends State<PollPage> {

  String _radioValue = '';
  String _initialRadioValue = '';
  Map<String, bool> _checkbox = <String, bool>{};
  bool _isSubmitting = false;

  void _handleRadioChanged(String? value, { bool isInitialValue = false }) {
    if(mounted) setState(() => _radioValue = '$value');
    if(isInitialValue) _initialRadioValue = '$value';
  }

  void _handleCheckboxChanged({ required String id, required bool value }) {
    _checkbox[id] = value;
    _checkbox = Map.from(_checkbox);
    if(mounted) setState(() {});
  }

  Future<void> _handleVote() async {
    if (mounted) setState(() => _isSubmitting = true);
    Items? item = Provider.of<PersistentState>(context, listen: false).currentItem;
    String? uid = Provider.of<PersistentState>(context, listen: false).currentUser!.uid;
    if(item != null && uid != null) {
      if (item.pollSettings!.closeDate!.isBefore(DateTime.now())) {
        // Poll has already closed
        return Future.value();
      }
      if (item.pollSettings!.multipleVote) {
        final _choices = Map.from(_checkbox);
        for (String choiceId in _choices.keys) {
          await FirebaseDatabase.instance
              .ref('options/${item.id}/choices/$choiceId/voted_by')
              .update({
                uid: (_choices[choiceId] ?? false) ? true : null
              });
        }
      } else {
        await FirebaseDatabase.instance
            .ref('options/${item.id}/choices/$_initialRadioValue/voted_by')
            .update({uid: null});
        await FirebaseDatabase.instance
            .ref('options/${item.id}/choices/$_radioValue/voted_by')
            .update({uid: true});
      }
    }
    _handlePop().then((willPop) {
      if(willPop) Navigator.of(context).pop();
    });
  }

  Future<bool> _handlePop() async {
    Provider.of<PersistentState>(context, listen: false).disposeItem();
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PersistentState>(builder: (context, appState, child) { 

      /***
       * Compute required booleans
       */

      bool isConfirmDisabled = false;
      if(appState.currentItem!.pollSettings!.multipleVote) {
        isConfirmDisabled = !_checkbox.values.contains(true);
      } else {
        isConfirmDisabled = _radioValue.isEmpty;
      }
      bool isOwner = appState.currentUser!.uid == appState.currentTeam!.owner;

      return VotoScaffold(
        useMenu: false,
        title: 'Vote',
        onWillPop: _handlePop,
        titleContext: appState.currentTeam!.name,
        body: Column(children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 20.0,
                left: 42.5,
                right: 42.5
              ),
              child: ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${appState.currentItem?.title}',
                        style: GoogleFonts.inter(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        'Closed on ${appState.currentItem!.pollSettings!.closeDateFormatted}',
                        style: GoogleFonts.inter(
                            fontSize: 12, fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    '${appState.currentItem!.description}',
                    style: GoogleFonts.inter(
                        fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 20.0),
                  PollBody(
                    isLoading: _isSubmitting,
                    isEditable: isOwner,
                    isAddable: isOwner || appState.currentItem!.pollSettings!.multipleVote,
                    isMultipleValue: appState.currentItem!.pollSettings!.multipleVote,
                    radioValue: _radioValue,
                    onRadioChanged: !(appState.currentItem!.pollSettings!.multipleVote) ? _handleRadioChanged : null,
                    onCheckboxChanged: _handleCheckboxChanged,
                  ),
                ]),
            ),
          ),
          ConfirmButton(
            confirmText: 'Vote',
            onConfirm: _handleVote,
            onCancel: () {
              _handlePop().then((willPop) {
                if (willPop) Navigator.of(context).pop();
              });
            },
            disabled: isConfirmDisabled,
          )
        ]),
      );
    });
  }
}
