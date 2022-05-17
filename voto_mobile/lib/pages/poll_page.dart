import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:voto_mobile/model/items.dart';
import 'package:voto_mobile/model/persistent_state.dart';
import 'package:voto_mobile/utils/color.dart';
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
  final Map<String, bool> _checkbox = <String, bool>{};
  bool _isSubmitting = false;
  late FToast fToast;

  void _handleRadioChanged(String? value, { bool isInitialValue = false, String? deletedId }) {
    if (value != null) {
      _radioValue = value;
      if(isInitialValue) _initialRadioValue = value;
    } else {
      if (deletedId == _initialRadioValue) {
        _initialRadioValue = '';
      }
      _radioValue = '';
    }
  }

  void _handleCheckboxChanged({ required String id, required bool? value }) {
    if (value != null) {
      _checkbox[id] = value;
    } else {
      _checkbox.remove(id);
    }
  }

  Future<void> _handleVote() async {
    Items? item =
        Provider.of<PersistentState>(context, listen: false).currentItem;
    String? uid =
        Provider.of<PersistentState>(context, listen: false).currentUser!.uid;
    final bool isValid = _radioValue.isNotEmpty || _checkbox.containsValue(true);
    if (!isValid) {
      _showErrorToast('At least one option is required');
      return;
    }
    if (mounted) setState(() => _isSubmitting = true);
    if (item != null && uid != null) {
      if (item.pollSettings!.closeDate!.isBefore(DateTime.now())) {
        // Poll has already closed
        return Future.value();
      }
      if (item.pollSettings!.multipleVote) {
        final _choices = Map.from(_checkbox);
        for (final choice in _choices.entries) {
          String choiceId = choice.key;
          bool isVoted = choice.value;
          await FirebaseDatabase.instance
              .ref('options/${item.id}/choices/$choiceId')
              .runTransaction((Object? choice) {
            if (choice == null) {
              return Transaction.abort();
            }

            Map<String, dynamic> _choice =
                Map<String, dynamic>.from(choice as Map);
            if (_choice['voted_by'] != null) {
              // Someone has chosen this before
              if ((_choice['voted_by'] as Map?)?.containsKey(uid) ?? false) {
                // This user has chosen before
                _choice['vote_count'] = isVoted
                    ? _choice['vote_count']
                    : (_choice['vote_count'] ?? 1) - 1;

                if (!isVoted) {
                  (_choice['voted_by'] as Map?)?.remove(uid);
                }
              } else {
                // This user has never chosen before
                _choice['vote_count'] = isVoted
                    ? (_choice['vote_count'] ?? 0) + 1
                    : _choice['vote_count'];

                if (isVoted) {
                  _choice['voted_by'][uid] = true;
                }
              }
            } else {
              // No one has chosen this before
              _choice['vote_count'] = isVoted
                  ? (_choice['vote_count'] ?? 0) + 1
                  : _choice['vote_count'];

              if (isVoted) {
                _choice['voted_by'] = {uid: true};
              }
            }
            return Transaction.success(_choice);
          });
          /***
           * Delay is needed to fix unknown bug
           */
          await Future.delayed(const Duration(milliseconds: 1));
        }
      } else if (_initialRadioValue != _radioValue) {
        Map<String, Object?> updates = {};
        if (_initialRadioValue.isNotEmpty) {
          updates['options/${item.id}/choices/$_initialRadioValue/voted_by/$uid'] =
              null;
          updates['options/${item.id}/choices/$_initialRadioValue/vote_count'] =
              ServerValue.increment(-1);
        } else {
          updates['options/${item.id}/total_vote'] = ServerValue.increment(1);
        }
        updates['options/${item.id}/choices/$_radioValue/voted_by/$uid'] = true;
        updates['options/${item.id}/choices/$_radioValue/vote_count'] =
            ServerValue.increment(1);
        FirebaseDatabase.instance.ref().update(updates);
      }
    }
    _handlePop().then((willPop) {
      if (willPop) Navigator.of(context).pop();
    });
  }

  void _handleVoteOwn() {
    _showErrorToast('The team owner did not allow you to vote your own option in this poll');
  }

  Future<bool> _handlePop() async {
    Provider.of<PersistentState>(context, listen: false).disposeItem();
    return Future.value(true);
  }

  void _showErrorToast(String text) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: VotoColors.black.shade600,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.clear, color: VotoColors.danger),
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

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PersistentState>(builder: (context, appState, child) { 

      /***
       * Compute required booleans
       */

      bool isConfirmDisabled = false;
      if(appState.currentItem?.pollSettings!.multipleVote ?? false) {
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
        body: appState.currentUser != null
            ? Column(children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 20.0, left: 42.5, right: 42.5),
                    child: ListView(children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            appState.currentItem?.title ?? '',
                            style: GoogleFonts.inter(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            'Closing on ' + (appState.currentItem?.pollSettings?.closeDateFormatted ?? ''),
                            style: GoogleFonts.inter(
                                fontSize: 12, fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      Text(
                        appState.currentItem?.description ?? '',
                        style: GoogleFonts.inter(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(height: 20.0),
                      PollBody(
                        isLoading: _isSubmitting,
                        isEditable: isOwner,
                        isAddable: isOwner ||
                            (appState.currentItem?.pollSettings!.allowAdd ?? false),
                        isMultipleValue:
                            (appState.currentItem?.pollSettings!.multipleVote ?? false),
                        allowVoteOwn:
                            (appState.currentItem?.pollSettings!.allowAdd ?? false)
                            &&
                            (appState.currentItem?.pollSettings!.allowVoteOwnOption ?? false),
                        onRadioChanged: _handleRadioChanged,
                        onCheckboxChanged: _handleCheckboxChanged,
                        onVoteOwn: _handleVoteOwn,
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
                  disabled: _isSubmitting,
                )
              ])
            : Container(),
      );
    });
  }
}
