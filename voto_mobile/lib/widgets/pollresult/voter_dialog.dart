import 'package:flutter/material.dart';
import 'package:voto_mobile/model/choice.dart';
import 'package:voto_mobile/model/users.dart';
import 'package:voto_mobile/utils/color.dart';
import 'package:voto_mobile/widgets/bottom_dialog.dart';
import 'package:voto_mobile/widgets/manageteam/membercard.dart';

class VoterDialog extends StatelessWidget {
  final String text;
  final String? owner;
  final int voteCount;
  final List<Users> voters;
  const VoterDialog({
    Key? key,
    required this.text,
    required this.voteCount,
    required this.voters,
    this.owner
  }) : super(key: key);

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
      title: "$text ($voteCount)",
      titleContext: owner,
      height: 0.6,
      child: ListView.separated(
        itemBuilder: (context, index) =>
            Membercard(
              image: voters[index].img ?? 'gs://cs21-voto.appspot.com/dummy/blank.webp',
              name: voters[index].displayName ?? ''
            ),
        separatorBuilder: (context, index) => _divider,
        itemCount: voters.length,
      ),
    );
  }
}