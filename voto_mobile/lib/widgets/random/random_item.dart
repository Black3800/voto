import 'package:collection/collection.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voto_mobile/model/choice.dart';
import 'package:voto_mobile/model/persistent_state.dart';
import 'package:voto_mobile/model/team.dart';
import 'package:voto_mobile/utils/color.dart';
import 'package:voto_mobile/widgets/create_item/heading.dart';
import 'package:voto_mobile/widgets/random/running_text.dart';

class RandomItem extends StatefulWidget {
  final Choice? singleChoice;
  final List<Choice>? choices;
  final bool? skipAnimation;
  final bool renderAsResult;
  final Function()? onAnimationEnded;
  final BuildContext? context;
  const RandomItem({
    Key? key,
    this.singleChoice,
    this.choices,
    this.skipAnimation,
    this.renderAsResult = false,
    this.onAnimationEnded,
    this.context
  }) : super(key: key);

  @override
  State<RandomItem> createState() => _RandomItemState();
}

class _RandomItemState extends State<RandomItem> {
  late Future<List<Choice>> _choices;

  Future<List<Choice>> _getMemberNames() async {
    Team? currentTeam = Provider.of<PersistentState>(widget.context ?? context, listen: false).currentTeam;
    if(currentTeam != null) {
      List<Choice> _members = [];
      for (String uid in currentTeam.members.keys) {
        final data = await FirebaseDatabase.instance.ref('users/$uid/display_name').get();
        _members.add(
          Choice(
            id: uid,
            text: data.value as String,
            win: uid == widget.singleChoice?.assignee
          )
        );
      }
      return _members;
    }
    return [];
  }

  @override
  void initState() {
    super.initState();
    if (widget.singleChoice == null) {
      _choices = Future.value(widget.choices);
    } else {
      _choices = _getMemberNames();
    }
  }

  @override
  void didUpdateWidget(covariant RandomItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.singleChoice == null) {
      _choices = Future.value(widget.choices);
    } else if (widget.singleChoice != oldWidget.singleChoice) {
      _choices = _getMemberNames();
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.singleChoice != null) Heading(widget.singleChoice!.text!, context: widget.context),
        const SizedBox(height: 15.0),
        Row(
          children: [
            Expanded(
              child: FutureBuilder(
                future: _choices,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final data = snapshot.data as List<Choice>;
                    return RunningText(
                      choices: data,
                      result: data.firstWhereOrNull((element) => element.win == true),
                      skipAnimation: widget.skipAnimation,
                      onAnimationEnded: widget.onAnimationEnded,
                      renderAsResult: widget.renderAsResult
                    );
                  } else {
                    return Container(
                      height: 84,
                      padding: const EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: VotoColors.gray
                      ),
                      child: const Center(
                        child: Center(
                                child: SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(strokeWidth: 2.0)),
                              )
                      )
                    );
                  }
                }
              )
            )
          ]),
      ],
    );
  }
}
