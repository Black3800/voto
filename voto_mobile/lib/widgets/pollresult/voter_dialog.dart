import 'package:flutter/material.dart';
import 'package:voto_mobile/model/choice.dart';
import 'package:voto_mobile/model/users.dart';
import 'package:voto_mobile/utils/color.dart';
import 'package:voto_mobile/widgets/bottom_dialog.dart';
import 'package:voto_mobile/widgets/manageteam/membercard.dart';

class VoterDialog extends StatefulWidget {
  final Choice choice;
  const VoterDialog({Key? key, required this.choice}) : super(key: key);

  @override
  State<VoterDialog> createState() => _VoterDialogState();
}

class _VoterDialogState extends State<VoterDialog> {
  List<Users> _voterList = [];

  Future<void> _getVoterList() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      // Generate a fake list (Should fetch DB here)
      _voterList = List<Users>.generate(widget.choice.voteCount ?? 0, (index) => const Users(displayName: 'Anakin'));
    });
  }

  @override
  void initState() {
    super.initState();
    _getVoterList();
  }

  final _divider = const Divider(
                          height: 15.0,
                          color: VotoColors.gray,
                          thickness: 1.0,
                          indent: 20.0,
                          endIndent: 20.0,
                        );

  @override
  Widget build(BuildContext context) {
    return BottomDialog(
      title: "${widget.choice.text} (${widget.choice.voteCount})",
      height: 0.6,
      child: ListView.separated(
        itemBuilder: (context, index) => Membercard(name: _voterList[index].displayName ?? ''),
        separatorBuilder: (context, index) => _divider,
        itemCount: _voterList.length,
      ),
    );
  }
}
